//
//  RepositoryTableViewCell.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

import UIKit
import SDWebImage

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = String(describing: RepositoryTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func bindViewModel(viewModel: RepositoryCellViewModel) {
        if let avatarUrl = viewModel.avatarUrl {
            iconImageView.sd_setImage(with: URL(string: avatarUrl))
        }
        
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
    }
}

// MARK: - Init Setup
extension RepositoryTableViewCell {
    private func setupCell() {
        self.selectionStyle = .none
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
    }
}
