//
//  RepositoriesListRouter.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import UIKit

protocol RepositoriesListRouterProtocol: AnyObject {
}

class RepositoriesListRouter: RepositoriesListRouterProtocol {
    private unowned let view: UIViewController
    private unowned let dataStore: RepositoriesListDataStore
    
    required init(view: UIViewController, interactor: RepositoriesListDataStore) {
        self.view = view
        self.dataStore = interactor
    }
    
    /*
     It's empty because there is no any transitions from the controller.
     */
}
