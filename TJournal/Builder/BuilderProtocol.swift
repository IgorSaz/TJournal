//
//  BuilderModuleProtocol.swift
//  TJournal
//
//  Created by Игорь Сазонов on 22.09.2021.
//

import UIKit

protocol BuilderProtocol {
    func createNewsFeedModule() -> UIViewController
    func createImageDetaileModule() -> UIViewController
}
