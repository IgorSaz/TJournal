//
//  NewsFeedViewModel.swift
//  TJournal
//
//  Created by Игорь Сазонов on 29.09.2021.
//

import Foundation


class NewsFeedViewModel {
    
    // MARK: - VAR
    private var news: News?
    
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }
    
    public var countItem: Int {
        newsList.count
    }
    
    public var newsList: [NewsItemModel] = []
}


// MARK: - PUBLIC FUNCTION

extension NewsFeedViewModel {
    public func getNews(completed: @escaping (String?) -> Void) {
        NetworkService.shared.getNews(sortingType: .baseUrl) { [weak self] (resultRequest) in
            switch resultRequest {
                case .success(let news):
                    self?.news = news
                    self?.writeDataToModel()
                    completed(nil)
                case .failure(let message):
                    completed(message.rawValue)
            }
        }
    }
    
    public func loadImage(idImage: String, completed: @escaping (Data) -> Void) {
        NetworkService.shared.loadImage(idImage: idImage) { (data) in
            completed(data)
        }
    }
}

// MARK: - PRIVATE FUNCTION

extension NewsFeedViewModel {
    private func writeDataToModel() {
        if let items = news?.result.items {
            for item in items {
                switch item {
                    case .onboarding(_):
                        break
                    case .entry(let data):
                        appendNewsItem(data: data)
                        break
                }
            }
        }
    }
    
    private func appendNewsItem(data: DataItem) {
        let date = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(data.date))) + " час"
        
        newsList.append(NewsItemModel(title: data.title,
                                      nameAuthor: data.author.name,
                                      nameSubsite: data.subsite.name,
                                      idImageSubsite: data.subsite.avatar.data.id,
                                      idImageNewsItem: nil,
                                      descreption: "",
                                      date: date,
                                      countVoets: ""))
    }
}
