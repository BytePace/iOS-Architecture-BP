//
//  ClassIdentifiable.swift
//
//  Created by Nikita Velichkin on 25/01/2020.
//  Copyright © 2020 Velichkin Nikita. All rights reserved.
//

protocol ClassIdentifiable {
    static var reuseId: String { get }
}

extension ClassIdentifiable {
    static var reuseId: String {
        return String(describing: self)
    }
}
