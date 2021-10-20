//
//  AppDelegate.swift
//  projectMovies
//
//  Created by Николай on 02.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	
	private let appCoordinator = AppCoordinatorImp(
		host: "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json"
	)
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = appCoordinator.navigationController
        window?.makeKeyAndVisible()
		
		appCoordinator.startScreen()
        
        return true
    }
}

