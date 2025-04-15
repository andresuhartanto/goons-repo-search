//
//  RepositoriesModel.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

struct RepositoriesModel: Codable {
    let totalCount: Int
    let items: [RepositoryModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

struct RepositoryModel: Codable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let language: String?
    let forksCount: Int
    let stargazersCount: Int
    let watchersCount: Int
    let openIssues: Int
    let owner: OwnerModel
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, owner, language
        case fullName = "full_name"
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case openIssues = "open_issues"
    }
}

struct OwnerModel: Codable {
    let id: Int
    let avatarUrl: String
    let login: String
    
    enum CodingKeys: String, CodingKey {
        case id, login
        case avatarUrl = "avatar_url"
    }
}
