//
//  RepositoriesDataSource.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 06.02.2022.
//

import UIKit

class RepositoriesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    // Mutable data
    var repositories: [RepositoriesListEntity.View.RepositoryInfoModel]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryTableViewCell = tableView.dequeue(RepositoryTableViewCell.self, indexPath)
        cell.display(title: repositories?[indexPath.row].title)
        cell.display(subtitle: repositories?[indexPath.row].subtitle)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


