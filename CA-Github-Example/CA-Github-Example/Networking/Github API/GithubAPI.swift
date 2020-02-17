//
//  GithubAPI.swift
//  Moon-iOS
//
//  Created by Nikita Velichkin on 11/02/2020.
//  Copyright © 2020 Scand. All rights reserved.
//

import RxSwift
import Moya

protocol GithubType {
    func searchRepositories(searchText: String) -> Observable<[Repository]>
}

class GithubAPI {

    private let provider: MoyaProvider<GithubPaths>
    
    init(provider: MoyaProvider<GithubPaths>) {
        self.provider = provider
    }
}

extension GithubAPI: GithubType {
    func searchRepositories(searchText: String) -> Observable<[Repository]> {
        return provider.rx
            .request(.repositories(searchText: searchText))
            .map(GithubAPIResponse.self)
            .map { $0.items }
            .asObservable()
    }
}
