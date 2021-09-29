//
//  NewsFeedViewModel.swift
//  TJournal
//
//  Created by Игорь Сазонов on 29.09.2021.
//

import Foundation


class NewsFeedViewModel {
    
    private var news: News?
    //var messageError: String?
    
    var NewsList: [NewsItemModel] = []
    
    public func getResultRequest(completed: @escaping (String?) -> Void) {
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
        
        let title = data.title
        let nameAuthor = data.author.name
        let nameSbsite = data.subsite.name
        let idImageSusite = data.subsite.avatar.data.id
        let idImageNewsItem: String? = nil
        let date = data.date
        
        let newsItem = NewsItemModel(title: title,
                                     nameAuthor: nameAuthor,
                                     nameSubsite: nameSbsite,
                                     idImageSubsite: idImageSusite,
                                     idImageNewsItem: idImageNewsItem,
                                     descreption: "",
                                     date: Date(timeIntervalSince1970: TimeInterval(date)))
        NewsList.append(newsItem)
    }
}

struct NewsItemModel {
    let title: String
    let nameAuthor: String
    let nameSubsite: String
    let idImageSubsite: String
    let idImageNewsItem: String?
    let descreption: String
    let date: Date
}
