//
//  RepositoriesListInteractor.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import RxSwift
import RxCocoa

final class RepositoriesListInteractor {
    var repositories = BehaviorRelay<[Repository]>(value: [])

    private let api = GithubAPI()
    private let disposeBag = DisposeBag()

    func fetchRepositories(searchText: String) {
        api.searchRepositories(searchText: searchText)
            .bind(to: repositories)
            .disposed(by: disposeBag)
    }
}
