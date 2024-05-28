//
//  HeroHeaderUIView.swift
//  Nertflix
//
//  Created by Lily Tran on 6/5/24.
//

import UIKit
protocol HeroHeaderUIViewDelegate: AnyObject {
    func onPlay(viewModel: TitlePreviewViewModel)
}

class HeroHeaderUIView: UIView {
    var model : Title?
    weak var delegate: HeroHeaderUIViewDelegate?
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false // to use constrain
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let playButton: UIButton = {
       
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false // to use constrain
        button.layer.cornerRadius = 5
        return button
    }()

    private let heroImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "paradise")
        return imageView
    }()
    
    // blur header image
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        downloadButton.addTarget(self, action: #selector(onDownload), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(onPlay), for: .touchUpInside)
        applyConstraints()
    }
    
    private func applyConstraints(){
        
        let playButtonConstaints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstaints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    public func configure(with model: Title) {
        self.model = model
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.poster_path ?? "")") else {
            return
        }
        
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func onDownload (sender: UIButton) {
        if let model = self.model {
            DataPersistenceManager.shared.downloadTitleWith(model: model) { result in
                switch result {
                case .success():
                    NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @objc func onPlay (sender: UIButton) {
        if let title = self.model {
            guard let titleName = title.original_title ?? title.original_name else {
                return
            }
            
            
            APICaller.shared.getMovie(with: titleName + " trailer") { [weak self] result in
                switch result {
                case .success(let videoElement):
                    guard let titleOverview = title.overview else {
                        return
                    }
                    let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
                    self?.delegate?.onPlay(viewModel: viewModel)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
}
