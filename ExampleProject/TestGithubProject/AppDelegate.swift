//
//  AppDelegate.swift
//  TestGithubProject
import UIKit

@_exported import BytepaceSwiftUtils

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainVc = RepositoriesListFabric.assembledScreen()
        
        let navigationController = UINavigationController(rootViewController: mainVc)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}
