//
//  RepositoryTableViewCell.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static let identifier = String(describing: RepositoryTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setupCell()
    }
    
    func bindViewModel(viewModel: RepositoryCellViewModel) {
        print("Setup Cell here")
    }
}

// MARK: - Init Setup
extension RepositoryTableViewCell {
    private func setupCell() {
        iconImageView.image = nil
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
    }
}
