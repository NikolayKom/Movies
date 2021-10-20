//
//  FilmDetailPresenter.swift
//  projectMovies
//
//  Created by Николай on 02.10.2021.
//

import Foundation

protocol FilmDetailPresenter: AnyObject {
    var filmTableViewCellItem: FilmTableViewCellItem { get }
}

final class FilmDetailPresenterImp: FilmDetailPresenter {
    
    private weak var viewController: FilmDetailControllerImp?
    var filmTableViewCellItem: FilmTableViewCellItem
    
    init(viewController: FilmDetailControllerImp, film: FilmTableViewCellItem) {
        self.viewController = viewController
		self.filmTableViewCellItem = film
    }
    
}
