//
//  BuilderModule.swift
//  TJournal
//
//  Created by Игорь Сазонов on 22.09.2021.
//

import UIKit

class BuilderModule: BuilderProtocol {
    
    static var shared = BuilderModule()
    
    public func createNewsFeedModule() -> UIViewController {
        let view = NewsFeedViewController()
        let viewModel = NewsFeedViewModel()
        view.viewModel = viewModel
        return view
    }
    
    public func createImageDetaileModule() -> UIViewController {
        return UIViewController()
    }
    
}
