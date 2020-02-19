//
//  IsPresenter.swift
//
//  Created by Nikita Velichkin on 11/02/2020.
//  Copyright © 2020 Velichkin Nikita. All rights reserved.
//

protocol IsPresenter {
    associatedtype Input
    associatedtype Output
    
    func buildOutput(with input: Input) -> Output

    func bindInputs(with input: Input)
    func configureOutputs(with input: Input) -> Output
}

extension IsPresenter {
    func buildOutput(with input: Input) -> Output {
        bindInputs(with: input)
        return configureOutputs(with: input)
    }
}
