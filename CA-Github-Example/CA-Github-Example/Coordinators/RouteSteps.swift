//
//  RouteSteps.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import RxFlow

enum RouteStep: Step {
    case repoList
    case repoDetails(repo: Repository)
}
