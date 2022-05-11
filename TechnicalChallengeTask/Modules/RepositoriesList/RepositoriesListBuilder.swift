//
//  RepositoriesListBuilder.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import UIKit

/*
   There is a builder to collect all module layers.
*/

struct RepositoriesListBuilder {
    typealias Controller = RepositoriesListViewController
    typealias Presenter = RepositoriesListPresenter
    
    func`default`() -> Controller {
        let vc = Controller.fromStoryboard
        let presenter = Presenter(view: vc)
        let interactor = RepositoriesListInteractor(presenter: presenter)
        let router = RepositoriesListRouter(view: vc, interactor: interactor)

        vc.initialSetup(interactor: interactor, router: router)
        return vc
    }
}
