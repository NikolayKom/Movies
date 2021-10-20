//
//  FilmTableViewCellItem.swift
//  Movies
//
//  Created by Николай on 03.10.2021.
//

import Foundation

struct FilmTableViewCellItem {
	
	/// Название фильма
	let title: String
	
	/// Локализованное название 
	let localizedTitle: String
	
	/// Рейтинг
	let rating: Double?
    
    /// Id
    let id: Int
    
    /// Описание
    let description: String?
    
    /// Обложка
    let imageUrl: String?
    
    /// Год
    let year: Int
}
