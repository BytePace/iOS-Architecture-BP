//
//  RepositoryDetailsInteractor.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import RxSwift
import RxCocoa

final class RepositoryDetailsInteractor {
    var repository: BehaviorRelay<Repository>

    init(repository: Repository) {
        self.repository = .init(value: repository)
    }
}
