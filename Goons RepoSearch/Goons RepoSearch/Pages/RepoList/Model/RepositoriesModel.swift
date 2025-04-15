//
//  RepositoriesModel.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

struct RepositoriesModel: Codable {
    let totalCount: Int
    let items: [RepositoryModel]
}

struct RepositoryModel: Codable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case fullName = "full_name"
    }
}

struct OwnerModel: Codable {
    let id: Int
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
    }
}
