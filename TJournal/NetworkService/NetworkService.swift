//
//  NetworkService.swift
//  TJournal
//
//  Created by Игорь Сазонов on 25.09.2021.
//

import Foundation

class NetworkService {
    static var shared = NetworkService()
    
    public func getNews(sortingType: SortingType, completed: @escaping (Result<News, ApiError>) -> Void) {
        let urlString = sortingType.url
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidUrl))
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                completed(.success(news))
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }.resume()
    }
        
    public func loadImage(idImage: String, completed: @escaping (Data) -> Void) {
        guard let url = URL(string: "https://leonardo.osnova.io/\(idImage)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            if let data = data {
                completed(data)
            }
        }.resume()
    }
}
