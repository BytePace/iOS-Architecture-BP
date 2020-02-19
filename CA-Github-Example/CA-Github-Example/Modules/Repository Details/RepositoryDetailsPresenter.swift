//
//  RepositoryDetailsPresenter.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import RxFlow
import RxCocoa
import RxSwift

protocol RepositoryDetailsPresenterProtocol {
    func buildOutput(with input: RepositoryDetailsPresenter.Input) -> RepositoryDetailsPresenter.Output
}

final class RepositoryDetailsPresenter: Stepper {
    private let interactor: RepositoryDetailsInteractor
    
    var steps = PublishRelay<Step>()
    
    init(_ interactor: RepositoryDetailsInteractor) {
        self.interactor = interactor
    }
}

// MARK: - UI Bindings

extension RepositoryDetailsPresenter: IsPresenter, RepositoryDetailsPresenterProtocol {
    struct Input {}

    struct Output {
        var name: Driver<String>
        var description: Driver<String?>
    }

    func bindInput(_ input: RepositoryDetailsPresenter.Input) {

    }

    func configureOutput(_ input: RepositoryDetailsPresenter.Input) -> RepositoryDetailsPresenter.Output {
        let name = interactor.repository
            .map { $0.name }
            .asDriver(onErrorJustReturn: "")

        let description = interactor.repository
            .map { $0.description }
            .asDriver(onErrorJustReturn: nil)

        return Output(name: name, description: description)
    }
}
