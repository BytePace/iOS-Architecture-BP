//
//  AppDelegate.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 17/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import UIKit
import RxFlow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let coordinator = FlowCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        startNavigation()
        return true
    }

    private func startNavigation() {
        let startFlow = StartFlow()

        Flows.whenReady(flow1: startFlow) { [unowned self] root in
            self.window = UIWindow()
            self.window?.rootViewController = root
            self.window?.makeKeyAndVisible()
        }

        coordinator.coordinate(flow: startFlow, with: OneStepper(withSingleStep: RouteStep.repoList))
    }
}
