//
//  DownloadsViewController.swift
//  Nertflix
//
//  Created by Lily Tran on 6/5/24.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private let downloadedTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    let downloadViewModel = DownloadViewModel()

    deinit {
        downloadViewModel.unregisNotificationCenter()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationView()
        setupTableView()
        fetchLocalStorageForDownload()
        downloadViewModel.regisNotificationCenter()
        downloadViewModel.updateItemDownload = { [weak self] in
            guard let `self` = self else { return }
            self.fetchLocalStorageForDownload()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }
    
    private func setupNavigationView() {
        view.backgroundColor = .systemBackground
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupTableView() {
        view.addSubview(downloadedTable)
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
    }
    
    private func fetchLocalStorageForDownload() {
        downloadViewModel.fetchLocalStorageForDownload { [weak self] result in
            switch result {
            case .success(let fetchSuccess):
                if fetchSuccess {
                    DispatchQueue.main.async {
                        self?.downloadedTable.reloadData()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadViewModel.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = downloadViewModel.titles[indexPath.row]
        cell.configure(with: TitlePreviewModel(titleName: (title.original_title ?? title.original_name) ?? "Unknown title name", posterURL: title.poster_path ?? ""))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            downloadViewModel.deleteTitle(at: indexPath.row) { [weak self] result in
                guard let `self` = self else { return }
                switch result {
                case .success(let isSuccess):
                    if isSuccess {
                        self.downloadedTable.deleteRows(at: [indexPath], with: .fade)
                        print("Deleted from the database success")
                    } else {
                        print("Deleted from the database fail")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = downloadViewModel.titles[indexPath.row]
        downloadViewModel.getMovive(at: indexPath.row) { [weak self] (result) in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    let titleName = title.original_title ?? title.original_name ?? ""
                    vc.configure(with: TitleModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
