//
//  BackwardPassableRouter.swift
//  BytepaceSwiftUtils
//
//  Created by Semen Ilin on 06.11.2020.
//  Copyright © 2020 Ruslan Musagitov. All rights reserved.
//

import Foundation
import UIKit

public protocol BackwardsPassableRouter {
    associatedtype PassType
    
    var backwardsPassableReceiver: BackwardsPassableReceiver? { get set }
    
    var backwardsIdentifier: String? { get set }
    
    func sendBack(_: PassType)
}

public extension BackwardsPassableRouter where Self: (RouterProtocol & Closable) {
    func sendBack(_ receivedData: PassType) {
        close()
        backwardsPassableReceiver?.receive(receivedData, identifier: backwardsIdentifier)
    }
}

public protocol BackwardsPassableReceiver {
    func receive<T>(_:T, identifier: String?)
}
