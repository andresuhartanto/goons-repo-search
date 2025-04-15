//
//  NetworkManager.swift
//  Goons RepoSearch
//
//  Created by Andre on 2025/4/15.
//

import Moya

class NetworkManager {
    static let shared = NetworkManager()
    private let provider = MoyaProvider<RepoSearchAPI>()
    
    private init() {}
    
    func searchRepositories(
        query: String,
        completion: @escaping (Result<[RepositoryModel], Error>) -> Void
    ) {
        provider.request(.searchRepo(query: query)) { result in
            switch result {
            case .success(let response):
                do {
                    let searchResponse = try JSONDecoder().decode(RepositoriesModel.self, from: response.data)
                    
                    completion(.success(searchResponse.items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
