//
//  IsPresenter.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 21/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

protocol IsPresenter {
    associatedtype Input
    associatedtype Output

    func bindInput(_ input: Input)
    func configureOutput(_ input: Input) -> Output

    func buildOutput(with input: Input) -> Output
}

extension IsPresenter {
    func buildOutput(with input: Input) -> Output {
        bindInput(input)

        let output = configureOutput(input)
        return output
    }
}

