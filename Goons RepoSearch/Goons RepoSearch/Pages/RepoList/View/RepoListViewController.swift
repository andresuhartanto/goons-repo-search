//
//  RepoListViewController.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

import UIKit

class RepoListViewController: UIViewController {
    @IBOutlet weak var repositoryTableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let refreshControl = UIRefreshControl()
    
    private let viewModel = RepoListViewModel(networkService: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        setupNavigationBar()
        setupSearchController()
        setupTableView()
        setupDismissKeyboardGesture()
    }
}

// MARK: - Initial Setup
extension RepoListViewController {
    private func setupNavigationBar() {
        self.title = "Repository Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupTableView() {
        repositoryTableView.register(UINib(nibName: RepositoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        repositoryTableView.dataSource = self
        repositoryTableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        repositoryTableView.addSubview(refreshControl)
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search repositories"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = false
    }
    
    private func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Actions
extension RepoListViewController {
    @objc private func refresh() {
        viewModel.refresh()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }
}

// MARK: - Navigation
extension RepoListViewController {
    private func navigateToDetail(viewModel: RepositoryDetailViewModel) {
        let repositoryDetailViewController = RepositoryDetailViewController(viewModel: viewModel)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(repositoryDetailViewController, animated: true)
    }
}

// MARK: - UITableView Delegate & DataSource
extension RepoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRepositories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else {
            fatalError("Could not dequeue repository cell.")
        }
        
        if let cellViewModel = viewModel.cellViewModel(at: indexPath.row) {
            cell.bindViewModel(viewModel: cellViewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = viewModel.repositoryDetailViewModel(at: indexPath.row) {
            searchController.searchBar.resignFirstResponder()
            
            navigateToDetail(viewModel: viewModel)
        }
    }
}

// MARK: - UISearchController Delegate
extension RepoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchRepositories(keyword: searchController.searchBar.text)
    }
}

// MARK: - RepoList ViewModel Delegate
extension RepoListViewController: RepoListViewModelDelegate {
    func didLoadRepositories() {
        repositoryTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func didFailedToLoadRepositories(error: any Error) {
        showAlert(title: "Error", message: error.localizedDescription)
        refreshControl.endRefreshing()
    }
}
