//
//  RepoSearchAPI.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

import Moya

enum RepoSearchAPI {
    case searchRepo(query: String)
}

extension RepoSearchAPI: TargetType {
    var baseURL: URL { URL(string: "https://api.github.com/")! }
    
    var path: String {
        switch self {
        case .searchRepo(query: let query):
            return "search/repositories"
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/vnd.github.v3+json"]
    }
    
    var method: Moya.Method {
        switch self {
        case .searchRepo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .searchRepo(query: query):
            let parameters: [String: Any] = ["q": query]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}

