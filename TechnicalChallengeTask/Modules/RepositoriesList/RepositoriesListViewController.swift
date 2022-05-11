//
//  RepositoriesListViewController.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import UIKit

protocol RepositoriesListViewControllerProtocol: AnyObject {
    func setupRepositories(_ repositories: [RepositoriesListEntity.View.RepositoryInfoModel])
    func showLoader(_ isNeedShow: Bool)
    func showErrorMessage(_ message: String) 
}

class RepositoriesListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var tryAgainButton: UIButton!
    @IBOutlet private weak var emptyTableLabel: UILabel!
    
    // MARK: - Properties
    static let builder = RepositoriesListBuilder()
    private var interactor: RepositoriesListInteractorProtocol!
    private var router: RepositoriesListRouterProtocol!
    
    private var dataSource: RepositoriesDataSource = RepositoriesDataSource()

    // MARK: - Setup
    
    func initialSetup(interactor: RepositoriesListInteractorProtocol, router: RepositoriesListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLabels()
        setupAccessibilityIdentifiers()
        showLoader(false)
        showErrorView(false)
        
        interactor.getRepositories()
    }
    
    private func setupLabels() {
        titleLabel.text = "Repositories: "
        emptyTableLabel.text = "Sorry, but there is no any repositories here."
    }
    
    private func setupTableView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        
        tableView.register(RepositoryTableViewCell.self)
    }
    
    private func setupAccessibilityIdentifiers() {
        tableView.accessibilityIdentifier = "repositoriesListTableView"
        tryAgainButton.accessibilityIdentifier = "tryAgainButton"
        errorView.accessibilityIdentifier = "errorView"
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadDataWithAnimation()
        }
    }
    
    private func showAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func showErrorView(_ isNeedShow: Bool) {
        DispatchQueue.main.async {
            self.errorView.isHidden = !isNeedShow
        }
    }
    
    private func showTableView(_ isNeedShow: Bool) {
        DispatchQueue.main.async {
            self.tableView.isHidden = !isNeedShow
        }
    }
    
    // MARK: - Actions
    @IBAction func tryAgainButtonClick() {
        interactor.getRepositories()
    }
}

extension RepositoriesListViewController: RepositoriesListViewControllerProtocol {
    func setupRepositories(_ repositories: [RepositoriesListEntity.View.RepositoryInfoModel]) {
        dataSource.repositories = repositories
        showTableView(!repositories.isEmpty)
        showErrorView(repositories.isEmpty)
        reloadTable()
    }
    
    func showLoader(_ isNeedShow: Bool) {
        DispatchQueue.main.async {
            if isNeedShow {
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
    
    func showErrorMessage(_ message: String) {
        showAlert(with: message)
        showErrorView(true)
    }
}
