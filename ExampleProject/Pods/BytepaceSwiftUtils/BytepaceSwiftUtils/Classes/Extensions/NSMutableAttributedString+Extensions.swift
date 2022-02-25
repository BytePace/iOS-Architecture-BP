//
//  ClassIdentifiable.swift
//  BytepaceSwiftUtils
//
//  Created by Semen Ilin on 05.05.2021.
//

import Foundation
import UIKit

public extension NSMutableAttributedString {
    convenience init(_ string: String, font: UIFont = .systemFont(ofSize: 16), color: UIColor = .white) {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.foregroundColor] = color
        attributes[.font] = font
        self.init(string: string, attributes: attributes)
    }
    
    convenience init(_ attributedStrings: NSAttributedString...) {
        self.init()
        attributedStrings.forEach {[unowned self] attributedString in
            append(attributedString)
        }
    }
    
    convenience init(format: NSAttributedString, _ arguments: NSAttributedString...) {
        self.init(format)
        for argument in arguments {
            guard let insertRange = string.range(of: "%@") else {
                break
            }
            let nsInsertRange = NSRange(insertRange, in: format.string)
            replaceCharacters(in: nsInsertRange, with: argument)
        }
    }
}
