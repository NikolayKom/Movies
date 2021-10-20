//
//  AppCoordinator.swift
//  Movies
//
//  Created by Николай on 03.10.2021.
//

import UIKit

protocol AppCoordinator: AnyObject {

	var navigationController: UINavigationController { get }
	
	/// Отобразить начальный экран
	func startScreen()
	
	/// Отобразить детальную информацию о фильме
	func openFilmsDetail(film: FilmTableViewCellItem)
}

final class AppCoordinatorImp: AppCoordinator {
	
	let navigationController = UINavigationController()
	
	private let host: String

	init(host: String) {
		self.host = host
	}
	
	func startScreen() {
		
		let viewController = FilmsViewControllerImp()
		viewController.presenter = FilmsPresenterImp(
			viewController: viewController,
			appCoordinator: self,
			filmsRequestPerformer: FilmsRequestPerformerImp(host: host)
		)
		
		navigationController.pushViewController(viewController, animated: false)
	}
	
	func openFilmsDetail(film: FilmTableViewCellItem) {
		let viewController = FilmDetailControllerImp()
        viewController.presenter = FilmDetailPresenterImp(viewController: viewController, film: film)
		navigationController.pushViewController(viewController, animated: true)
        
	}
}
