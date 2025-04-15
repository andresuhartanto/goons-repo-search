//
//  RepositoryDetailViewController.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

import UIKit

class RepositoryDetailViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    private let viewModel: RepositoryDetailViewModel
    
    init(viewModel: RepositoryDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
}

// MARK: - Initial Setuop
extension RepositoryDetailViewController {
    private func setupNavigationBar() {
        self.title = viewModel.login
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupView() {
        avatarImageView.sd_setImage(with: URL(string: viewModel.ownerIcon))
        
        nameLabel.text = viewModel.name
        languageLabel.text = viewModel.languageText()
        starsLabel.text = viewModel.starsText()
        watchersLabel.text = viewModel.watchersText()
        forksLabel.text = viewModel.forksText()
        issuesLabel.text = viewModel.openIssuesText()
    }
}
