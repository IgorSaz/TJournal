//
//  SortingType.swift
//  TJournal
//
//  Created by Игорь Сазонов on 30.09.2021.
//

import Foundation

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
