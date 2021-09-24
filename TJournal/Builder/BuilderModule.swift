//
//  BuilderModule.swift
//  TJournal
//
//  Created by Игорь Сазонов on 22.09.2021.
//

import UIKit

class Builder: BuilderProtocol {
    
    public func createNewsFeedModule() -> UIViewController {
        return UIViewController()
    }
    
    public func createImageDetaileModule() -> UIViewController {
        return UIViewController()
    }
    
}
