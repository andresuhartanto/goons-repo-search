//
//  RepoListViewModel.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

import Foundation

protocol RepoListViewModelDelegate: AnyObject {
    func didLoadRepositories()
    func didFailedToLoadRepositories(error: Error)
}

class RepoListViewModel {
    weak var delegate: RepoListViewModelDelegate?
    
    var repositories: [RepositoryModel] = []
    private var keyword: String?
    private var searchWorkItem: DispatchWorkItem?
    private var debounceDelay: TimeInterval = 0.5
    
    func searchRepositories(keyword: String?) {
        searchWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let keyword = keyword, keyword != "" else {
                self?.clear()
                return
            }
            
            self?.keyword = keyword
            
            print("Searching for: \(keyword)")
            NetworkManager.shared.searchRepositories(query: keyword) { [weak self] result in
                switch result {
                case .success(let repositories):
                    self?.repositories = repositories
                    
                    DispatchQueue.main.async {
                        self?.delegate?.didLoadRepositories()
                    }
                case .failure(let failure):
                    print("Error searching repositories: \(failure)")
                    
                    DispatchQueue.main.async {
                        self?.delegate?.didFailedToLoadRepositories(error: failure)
                    }
                }
            }
        }
        
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + debounceDelay, execute: workItem)
    }
    
    func repository(at index: Int) -> RepositoryModel? {
        guard index >= 0 && index < repositories.count else {
            return nil
        }
        
        return repositories[index]
    }
    
    func cellViewModel(at index: Int) -> RepositoryCellViewModel? {
        guard let repository = repository(at: index) else {
            return nil
        }
        
        return RepositoryCellViewModel(repository: repository)
    }
    
    func repositoryDetailViewModel(at index: Int) -> RepositoryDetailViewModel? {
        guard let repository = repository(at: index) else {
            return nil
        }
        
        return RepositoryDetailViewModel(repository: repository)
    }
    
    func numberOfRepositories() -> Int {
        return repositories.count
    }
    
    func clear() {
        keyword = nil
        repositories.removeAll()
        
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didLoadRepositories()
        }
    }
    
    func refresh() {
        searchRepositories(keyword: self.keyword)
    }
}
