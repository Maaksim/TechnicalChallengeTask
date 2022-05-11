//
//  RepositoriesListPresenter.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import Foundation

protocol RepositoriesListPresenterProtocol {
    func configureRepositories(items: [RepositoriesListEntity.Response.RepositoriesResponse])
    func showLoader(_ isNeedShow: Bool)
    func handleError(_ errorMessage: String)
}

class RepositoriesListPresenter: RepositoriesListPresenterProtocol {
    private unowned let view: RepositoriesListViewControllerProtocol
    
    required init(view: RepositoriesListViewControllerProtocol) {
        self.view = view
    }
    
    // Prepare data for the show in view controller
    func configureRepositories(items: [RepositoriesListEntity.Response.RepositoriesResponse]) {
        var viewItems: [RepositoriesListEntity.View.RepositoryInfoModel] = []
        
        items.forEach { item in
            var viewItem = RepositoriesListEntity.View.RepositoryInfoModel()
            viewItem.title = item.name
            viewItem.subtitle = item.description
            viewItems.append(viewItem)
        }
        
        self.view.setupRepositories(viewItems)
    }
    
    func showLoader(_ isNeedShow: Bool) {
        view.showLoader(isNeedShow)
    }
    
    func handleError(_ errorMessage: String) {
        view.showErrorMessage(errorMessage)
    }
}
