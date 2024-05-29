//
//  HomeViewModel.swift
//  Nertflix
//
//  Created by Ringme on 29/05/2024.
//

import Foundation

import UIKit
import CoreData

class HomeViewModel {
    var randomTrendingMovie: Title?
    let sectionTitles: [String] = ["Trending Movies","Trending TV", "Popular", "Upcoming Movie", "Top rated"]
    
    func configureHeaderView(completion: @escaping (Title) -> Void) {
        APICaller.shared.getTrendingMovies { result in
            
            APICaller.shared.getTrendingMovies { [weak self] result in
                switch result {
                case.success(let titles):
                    if let selectedTitle = titles.randomElement() {
                        self?.randomTrendingMovie = titles.randomElement()
                        completion(selectedTitle)
                    }
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func onLogout() {
        UserDefaults.standard.setValue(false, forKey: "IsLogin")
        App.shared.switchRoot(type: .login)
    }
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getTrendingMovies { result in
            completion(result)
        }
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getTrendingTvs { result in
            completion(result)
        }
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getPopular { result in
            completion(result)
        }
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getUpcomingMovies { result in
            completion(result)
        }
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getTopRated { result in
            completion(result)
        }
    }
}
