//
//  ClassIdentifiable.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 21/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

protocol ClassIdentifiable {
    static var reuseId: String { get }
}

extension ClassIdentifiable {
    static var reuseId: String {
        return String(describing: self)
    }
}

