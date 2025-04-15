//
//  RepositoryDetailViewModel.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

struct RepositoryDetailViewModel {
    let name: String
    let login: String
    let ownerIcon: String
    let programLanguage: String
    let stargazerCount: Int
    let watcherCount: Int
    let forkCount: Int
    let openIssueCount: Int
    
    init(repository: RepositoryModel) {
        self.name = repository.name
        self.login = repository.owner.login
        self.ownerIcon = repository.owner.avatarUrl
        self.programLanguage = repository.language ?? "-"
        self.stargazerCount = repository.stargazersCount
        self.watcherCount = repository.watchersCount
        self.forkCount = repository.forksCount
        self.openIssueCount = repository.openIssues
    }
    
    func languageText() -> String {
        return "Written in: \(programLanguage)"
    }
    
    func starsText() -> String {
        return "\(stargazerCount) stars"
    }
    
    func watchersText() -> String {
        return "\(watcherCount) watchers"
    }
    
    func forksText() -> String {
        return "\(forkCount) forks"
    }
    
    func openIssuesText() -> String {
        return "\(openIssueCount) open issues"
    }
}
