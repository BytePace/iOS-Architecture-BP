//
//  GithubPaths.swift
//
//  Created by Nikita Velichkin on 11/02/2020.
//  Copyright © 2020 Scand. All rights reserved.
//

import Moya
import Alamofire

enum GithubPaths {
    case repositories(searchText: String)
}

extension GithubPaths: TargetType {
    var baseURL: URL {
        guard let baseURL = URL(string: "https://api.github.com") else { fatalError("Incorrect baseURL") }
        return baseURL
    }

    var path: String {
        switch self {
        case .repositories:
            return "/search/repositories"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .repositories(searchText):
            return .requestParameters(parameters: ["q": searchText], encoding: URLEncoding())
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
