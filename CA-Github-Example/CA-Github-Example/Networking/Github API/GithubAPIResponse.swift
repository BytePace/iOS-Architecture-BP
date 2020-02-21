//
//  GithubAPIResponse.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 18/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

struct GithubAPIResponse: Decodable {
    var count: Int
    var isIncomplete: Bool
    var items: [Repository]

    enum CodingKeys: String, CodingKey {
        case count = "total_count"
        case isIncomplete = "incomplete_results"
        case items
    }
}
