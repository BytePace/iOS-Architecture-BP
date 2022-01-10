//
//  URLRoute.swift
//  TestGithubProject
//


import Foundation
import UIKit

protocol URLRoute {
    func openUrl(_ url: URL)
}

extension URLRoute {
    func openUrl(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
