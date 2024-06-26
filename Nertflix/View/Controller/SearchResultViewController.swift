//
//  SearchResultViewController.swift
//  Nertflix
//
//  Created by Lily Tran on 16/5/24.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: TitleModel)
}

class SearchResultsViewController: UIViewController {
    
    let searchResultViewModel = SearchResultViewModel()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    convenience init (titles: [Title]) {
        self.init()
        searchResultViewModel.titles = titles
    }
    
    public let searchResultsCollectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    
}


extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultViewModel.titles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        let title = searchResultViewModel.titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = searchResultViewModel.titles[indexPath.row]
        let titleName = title.original_title ?? ""
        
        searchResultViewModel.getMovie(titleName: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.delegate?.searchResultsViewControllerDidTapItem(TitleModel(title: title.original_title ?? "", youtubeView: videoElement, titleOverview: title.overview ?? ""))

                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
