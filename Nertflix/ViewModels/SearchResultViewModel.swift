//
//  SearchResultViewModel.swift
//  Nertflix
//
//  Created by Ringme on 29/05/2024.
//

import Foundation

import UIKit
import CoreData

class SearchResultViewModel {
    public var titles: [Title] = [Title]()
    
    func getMovie(titleName: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        APICaller.shared.getMovie(with: titleName) { result in
           completion(result)
        }
    }
}
