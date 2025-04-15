//
//  RepoListViewModel.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

struct RepoListViewModel {
    var repositories: [RepositoryModel] = []
    
    func searchRepositories(keyword: String) async throws {
        
    }
    
    func repository(at index: Int) -> RepositoryModel? {
        guard index >= 0 && index < repositories.count else {
            return nil
        }
        
        return repositories[index]
    }
}
