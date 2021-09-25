//
//  NetworkServiceProtocol.swift
//  TJournal
//
//  Created by Игорь Сазонов on 25.09.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func request()
}

enum ErrorMessage: String, Error {
    case notURL = "Not URL"
}
