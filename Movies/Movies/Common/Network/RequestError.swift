//
//  RequestError.swift
//  Movies
//
//  Created by Николай on 03.10.2021.
//

import Foundation

enum RequestError: Error {
	case connection
	case request(description: String)
	case persing
	case unknow
	case url
	
	var textError: String {
		switch self {
		case .connection:
			return "Нет интернета"
		case .request(let description):
			return description
		case .persing:
			return "Не получилось распарсить объект"
		case .unknow:
			return "Что-то пошло не так!"
		case .url:
			return "Ошибка в URL"
		}
	}
}
