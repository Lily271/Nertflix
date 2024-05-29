//
//  UpCommingViewModel.swift
//  Nertflix
//
//  Created by Ringme on 29/05/2024.
//

import Foundation

import UIKit
import CoreData

class UpCommingViewModel {
    var titles: [Title] = [Title]()
    
    func fetchUpcoming(completion: @escaping (Bool, Error?) -> Void) {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                completion(true, nil)
            case.failure(let error):
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
}
