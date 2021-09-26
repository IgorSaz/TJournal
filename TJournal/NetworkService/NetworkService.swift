//
//  NetworkService.swift
//  TJournal
//
//  Created by Игорь Сазонов on 25.09.2021.
//

import Foundation

class NetworkService {
    static var shared = NetworkService()
    
    func getNews(sortingType: SortingType, completed: @escaping (Result<News, ApiError>) -> Void) {
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
                
//                DispatchQueue.main.async {
//                    completed(.success(news))
//                }
                
                completed(.success(news))
                
//                self.loadImage(idImage: "") { (result) in
//                    switch result {
//                        case .success(let data):
//                            print(data)
//                        case .failure(let error):
//                            print(error)
//                    }
//                }
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }.resume()
    }
    
    func loadImage(idImage: String, completed: @escaping (Result<Data, ApiError>) -> Void) {
        let urlString = "https://leonardo.osnova.io/\(idImage)"
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completed(.failure(.unableToComplete))
                return
            }
            
            if let data = data {
                completed(.success(data))
            } else {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    func returnIdImage(indexItem: Int, news: News) -> String {
        let item = news.result.items[indexItem]
        switch item {
            case .onboarding(let massDataItem):
                print(massDataItem)
                break
            case .entry(let data):
                print(data)
                return data.subsite.avatar.data.id
        }
        return ""
    }
}

enum ApiError: String, Error {
    case invalidUrl = "Адрес страницы не действителен!!!"
    case unableToComplete = "Проверьте соединение с интернетом!!!"
    case invalidResponse = "Ответ сервера не валидный!!!"
    case invalidData = "Не валидные данные!!!"
}

enum SortingType {
    
    case baseUrl
    case hotness
    case date
    case day
    case week
    case month
    case year
    case all
    
    var baseUrl: String {
        return "https://api.tjournal.ru/v2.0/timeline"
    }
    
    var url: String {
        switch self {
            case .baseUrl:
                return baseUrl
            case .hotness:
                return baseUrl + "?sorting=hotness"
            case .date:
                return baseUrl + "?sorting=date"
            case .day:
                return baseUrl + "?sorting=day"
            case .week:
                return baseUrl + "?sorting=week"
            case .month:
                return baseUrl + "?sorting=month"
            case .year:
                return baseUrl + "?sorting=year"
            case .all:
                return baseUrl + "?sorting=all"
        }
    }
}
