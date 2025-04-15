//
//  RepositoryCellViewModel.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

struct RepositoryCellViewModel {
    var name: String
    var description: String?
    var avatarUrl: String?
    
    init(repository: RepositoryModel) {
        self.name = repository.name
        self.description = repository.description
        self.avatarUrl = repository.owner.avatarUrl
    }
}
