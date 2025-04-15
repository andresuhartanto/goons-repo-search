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
    let owner: OwnerModel
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, owner
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
