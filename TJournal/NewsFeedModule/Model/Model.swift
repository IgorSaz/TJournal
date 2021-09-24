//
//  Post.swift
//  TJournal
//
//  Created by Игорь Сазонов on 22.09.2021.
//

import Foundation

struct Request: Codable {
    let result: Result
}

struct Result: Codable {
    let items: [Item]
}

struct Item: Codable {
    let data: Data
}

struct Data: Codable {
    let author: Author
    let subsite: Subsite
    let title: String
    let blocks: [Block]
}

struct Subsite: Codable {
    let name: String
    let avatar: Avatar
}

struct Author: Codable {
    let name: String
    let avatar: Avatar
}

struct Avatar: Codable {
    let data: ImageData
}

struct ImageData: Codable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
    }
}

struct Block: Codable {
    let type: String
    let data: MediaData
}

struct MediaData: Codable {
    let items: [MediaItem]?
}

struct MediaItem: Codable {
    let image: Image
}

struct Image: Codable {
    let data: ImageData
}
