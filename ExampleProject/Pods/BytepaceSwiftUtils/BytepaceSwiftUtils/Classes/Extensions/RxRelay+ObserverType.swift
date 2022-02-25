//
//  RxRelay+ObserverType.swift
//  BytepaceSwiftUtils
//
//  Created by Semen Ilin on 05.05.2021.
//

/// Be aware that relays accept only .next events

import Foundation
import RxSwift
import RxRelay

extension PublishRelay: ObserverType {
    public func on(_ event: Event<Element>) {
        if case let .next(element) = event {
            self.accept(element)
        }
    }
}

extension BehaviorRelay: ObserverType {
    public func on(_ event: Event<Element>) {
        if case let .next(element) = event {
            self.accept(element)
        }
    }
}
