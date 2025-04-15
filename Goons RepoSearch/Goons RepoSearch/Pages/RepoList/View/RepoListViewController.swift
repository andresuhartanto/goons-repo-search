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
    
    private let viewModel = RepoListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchController()
        setupTableView()
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
        repositoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.identifier)
        repositoryTableView.dataSource = self
        repositoryTableView.delegate = self
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
}

// MARK: - UITableView Delegate & DataSource
extension RepoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier) else {
            fatalError("Could not dequeue repository cell.")
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - UISearchController Delegate
extension RepoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("Seaching for: \(searchController.searchBar.text ?? "No text")")
    }
}
