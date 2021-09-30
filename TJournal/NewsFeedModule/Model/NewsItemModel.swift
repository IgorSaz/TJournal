//
//  NewsItemModel.swift
//  TJournal
//
//  Created by Игорь Сазонов on 29.09.2021.
//

import Foundation
import UIKit

struct NewsItemModel {
    let title: String
    let nameAuthor: String
    let nameSubsite: String
    let idImageSubsite: String
    var subsiteImage: UIImage?
    let idImageNewsItem: String?
    var newsItemImage: UIImage?
    let descreption: String
    let date: String
    let countVoets: String
}
