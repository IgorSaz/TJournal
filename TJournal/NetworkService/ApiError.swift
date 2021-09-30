//
//  ApiError.swift
//  TJournal
//
//  Created by Игорь Сазонов on 30.09.2021.
//

import Foundation

enum ApiError: String, Error {
    case invalidUrl = "Адрес страницы не действителен!!!"
    case unableToComplete = "Проверьте соединение с интернетом!!!"
    case invalidResponse = "Ответ сервера не валидный!!!"
    case invalidData = "Не валидные данные!!!"
}
