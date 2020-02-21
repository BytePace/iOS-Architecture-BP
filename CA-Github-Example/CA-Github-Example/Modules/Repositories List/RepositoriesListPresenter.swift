//
//  RepositoriesListPresenter.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import RxFlow
import RxCocoa
import RxSwift
import RxDataSources

protocol RepositoriesListPresenterProtocol {
    func buildOutput(with input: RepositoriesListPresenter.Input) -> RepositoriesListPresenter.Output
}

final class RepositoriesListPresenter: Stepper {
    var steps = PublishRelay<Step>()

    private let interactor: RepositoriesListInteractor
    private let disposeBag = DisposeBag()

    init(_ interactor: RepositoriesListInteractor) {
        self.interactor = interactor
    }
}

extension RepositoriesListPresenter: IsPresenter, RepositoriesListPresenterProtocol {
    struct Input {
        var searchText: Observable<String>
        var repoSelected: Observable<Repository>
    }
    
    struct Output {
        var dataSource: Driver<[SectionModel<String, Repository>]>
    }

    func bindInput(_ input: RepositoriesListPresenter.Input) {
        disposeBag.insert(
            input.searchText.subscribe(onNext: { [weak self] text in
                self?.interactor.fetchRepositories(searchText: text)
            }),
            input.repoSelected
                .map(RouteStep.repoDetails(repo:))
                .bind(to: steps)
        )
    }

    func configureOutput(_ input: RepositoriesListPresenter.Input) -> RepositoriesListPresenter.Output {
        let dataSource = interactor.repositories
            .map { [SectionModel(model: "", items: $0)] }
            .asDriver(onErrorJustReturn: [])

        return Output(dataSource: dataSource)
    }
}
