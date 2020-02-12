//
//  IsPresenter.swift
//
//  Created by Nikita Velichkin on 11/02/2020.
//  Copyright © 2020 Velichkin Nikita. All rights reserved.
//

protocol IsPresenter {
    associatedtype Input
    associatedtype Output
    
    func buildOutput(input: Input) -> Output
}
