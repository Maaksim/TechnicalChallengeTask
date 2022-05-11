//
//  RepositoriesListInteractor.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import Foundation

protocol RepositoriesListInteractorProtocol {
    func getRepositories()
}

protocol RepositoriesListDataStore: AnyObject {
}

class RepositoriesListInteractor: RepositoriesListInteractorProtocol, RepositoriesListDataStore {
    private let presenter: RepositoriesListPresenterProtocol?
    private let repositoriesApi = RepositoriesRequest()

    required init(presenter: RepositoriesListPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getRepositories() {
        presenter?.showLoader(true)
        
        repositoriesApi.getRepositories { [weak self] response in
            guard let self = self else {return}
            
            switch response {
            case .success(let items):
                self.presenter?.configureRepositories(items: items)
            case .failure(let error):
                self.presenter?.handleError(error.localizedDescription)
            }
            
            self.presenter?.showLoader(false)
        }
    }

}
