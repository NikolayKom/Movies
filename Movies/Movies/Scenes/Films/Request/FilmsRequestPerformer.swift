//
//  FilmsRequestPerformer.swift
//  Movies
//
//  Created by Николай on 03.10.2021.
//

import Foundation

protocol FilmsRequestPerformer {
	func request(completed: @escaping (_ result: Result<FilmsDTO, RequestError>) -> Void)
}

final class FilmsRequestPerformerImp: FilmsRequestPerformer {
	
	private let host: String
	
	init(host: String) {
		self.host = host
	}
	
	func request(completed: @escaping (_ result: Result<FilmsDTO, RequestError>) -> Void) {
		
		guard Reachability.isConnectedToNetwork() else {
			completed(.failure(.connection))
			return
		}
		
		guard let url = URL(string: host) else {
			completed(.failure(.url))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, _, error in
			
			if let error = error {
				completed(.failure(.request(description: error.localizedDescription)))
			}
			
			if let data = data {
				
				do {
					let dto = try JSONDecoder().decode(FilmsDTO.self, from: data)
					completed(.success(dto))
				} catch {
					completed(.failure(.persing))
				}

			} else {
				completed(.failure(.unknow))
			}
			
		}.resume()
	}
}
