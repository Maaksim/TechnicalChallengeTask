//
//  RepositoryTableViewCell.swift
//  TechnicalChallengeTask
//
//  Created by Maksym Vitovych on 04.02.2022.
//

import UIKit

protocol RepositoryTableViewCellProtocol {
    func display(title: String?)
    func display(subtitle: String?)
}

class RepositoryTableViewCell: UITableViewCell {
    // MARK: - @IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetContent()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetContent()
    }
     
    private func resetContent() {
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
}

extension RepositoryTableViewCell: RepositoryTableViewCellProtocol {
    func display(title: String?) {
        titleLabel.text = title
    }
    
    func display(subtitle: String?) {
        subtitleLabel.text = subtitle
    }
}
