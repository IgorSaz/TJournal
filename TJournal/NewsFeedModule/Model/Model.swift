//
//  Post.swift
//  TJournal
//
//  Created by Игорь Сазонов on 22.09.2021.
//

import Foundation

struct News: Decodable {
    let message: String
    let result: ResultRequest
}

struct ResultRequest: Decodable {
    let items: [Item]
}

//struct Item: Codable {
//    let type: String
//    let data: T
//}

enum Item: Decodable {
    case onboarding(Array<DataItem?>)
    case entry(DataItem)

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "onboarding":
            let data = try container.decode(Array<DataItem?>.self, forKey: .data)
            self = .onboarding(data)
        case "entry":
            let data = try container.decode(DataItem.self, forKey: .data)
            self = .entry(data)
        default:
            throw DecodingError.unknownType
        }
    }

    private enum CodingKeys: String, CodingKey {
        case type
        case data
    }

    private enum DecodingError: String, Error {
        case unknownType
    }
}

struct DataItem: Decodable {
    let author: Author
}

struct Subsite: Decodable {
    let name: String
    let avatar: Avatar
}

struct Author: Decodable {
    let name: String
    let avatar: Avatar
}

struct Avatar: Decodable {
    let data: ImageData
}

struct ImageData: Decodable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
    }
}

struct Block: Decodable {
    let type: String
    let data: MediaData
}

struct MediaData: Decodable {
    let items: [MediaItem]?
}

struct MediaItem: Decodable {
    let image: Image
}

struct Image: Decodable {
    let data: ImageData
}
