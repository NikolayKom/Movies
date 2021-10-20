//
//  Film.swift
//  Movies
//
//  Created by Николай on 03.10.2021.
//

import Foundation

struct Film: Codable {
	let id: Int
	let name: String
	let localizedName: String
	let year: Int
	let rating: Double?
	let imageUrl: String?
	let description: String?
	
	enum CodingKeys: String,CodingKey {
		case id
		case name
		case localizedName = "localized_name"
		case year
		case rating
		case imageUrl = "image_url"
		case description
	}
}
