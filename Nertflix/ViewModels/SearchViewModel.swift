//
//  SearchViewModel.swift
//  Nertflix
//
//  Created by Ringme on 29/05/2024.
//

import Foundation

import UIKit
import CoreData

class SearchViewModel {
    public var titles: [Title] = [Title]()
    
    func fetchDiscoverMovies(completion: @escaping (Bool, Error?) -> Void) {
        APICaller.shared.getDiscoverMovies { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
                print(error.localizedDescription)
            }
        }
    }
    
    func getMovie(titleName: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        APICaller.shared.getMovie(with: titleName) { result in
            completion(result)
        }
    }
    
    func searchMovie(searchBar: String?, completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let query = searchBar,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3 else {
            return
        }
        
        APICaller.shared.search(with: query) { result in
            completion(result)
        }
    }
}
