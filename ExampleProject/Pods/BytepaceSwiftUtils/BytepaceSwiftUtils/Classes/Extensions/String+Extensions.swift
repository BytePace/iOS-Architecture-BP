//
//  String+Extension.swift
//  BytepaceSwiftUtils
//
//  Created by Ruslan Musagitov on 11.12.2020.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizedWithFormat(_ arguments: CVarArg...) -> String {
        return String(format: self.localized, arguments: arguments)
    }
}
