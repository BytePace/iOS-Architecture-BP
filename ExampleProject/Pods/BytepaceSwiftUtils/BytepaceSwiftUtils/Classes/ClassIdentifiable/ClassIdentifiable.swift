//
//  ClassIdentifiable.swift
//  BytepaceSwiftUtils
//
//  Created by Semen Ilin on 05.05.2021.
//

import UIKit

public protocol ClassIdentifiable: AnyObject {
    static var reuseId: String { get }
}

public extension ClassIdentifiable {
    static var reuseId: String {
        return String(describing: self)
    }
}

public extension UIView {
    func dequeueError<T>(withIdentifier reuseIdentifier: String, type _: T) -> String {
        return "Couldn't dequeue \(T.self) with identifier \(reuseIdentifier)"
    }
}
