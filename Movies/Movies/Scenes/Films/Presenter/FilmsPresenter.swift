//
//  FilmsPresenter.swift
//  projectMovies
//
//  Created by Николай on 02.10.2021.
//

import Foundation

protocol FilmsPresenter: AnyObject {
	
	var filmSections: [FilmsSection] { get }
	
	func loadData()
    
    func openDetailFilm(film: FilmTableViewCellItem)
    
}

final class FilmsPresenterImp: FilmsPresenter {
	
	var filmSections: [FilmsSection] = []
	
	private weak var viewController: FilmsViewController?
	private weak var appCoordinator: AppCoordinator?
	private let filmsRequestPerformer: FilmsRequestPerformer
	
	init(
		viewController: FilmsViewController,
		appCoordinator: AppCoordinator,
		filmsRequestPerformer: FilmsRequestPerformer
		
	) {
		self.viewController = viewController
		self.appCoordinator = appCoordinator
		self.filmsRequestPerformer = filmsRequestPerformer
	}
	
	func loadData() {
        viewController?.showActivityIndicator()
		filmsRequestPerformer.request { [weak self] result in
			guard let self = self else { return }
            self.viewController?.hideActivityIndicator()
			switch result {
			case .success(let dto):
				self.filmSections = self.createFilmSections(dto: dto)
				self.viewController?.reloadTableView()

			case .failure(let error):
				self.viewController?.showAlert(title: "Ошибка", message: error.textError)
			}
		}
	}
    
	func openDetailFilm(film: FilmTableViewCellItem) {
		appCoordinator?.openFilmsDetail(film: film)
	}
	
	private func createFilmSections(dto: FilmsDTO) -> [FilmsSection] {
		var resultArray = [FilmsSection]()
		
		let years = Set(dto.films.map { $0.year })
		
		years.forEach { year in
		
			let filmItems = dto.films
				.filter { $0.year == year }
                .map {
                    FilmTableViewCellItem(
                        title: $0.name,
                        localizedTitle: $0.localizedName,
                        rating: $0.rating,
                        id: $0.id,
                        description: $0.description,
                        imageUrl: $0.imageUrl,
                        year: $0.year)
                    
                }
                .sorted { film1, film2 in
                    let rating1 = film1.rating ?? 0
                    let rating2 = film2.rating ?? 0
                    return rating1 > rating2
                }
			
			resultArray.append(FilmsSection(year: year, filmItems: filmItems))
        }
		return resultArray.sorted(by: { $0.year < $1.year })
	}
}
