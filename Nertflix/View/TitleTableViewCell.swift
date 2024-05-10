//
//  TitleTableViewCell.swift
//  Nertflix
//
//  Created by Lily Tran on 10/5/24.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints == false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlesPosterUIImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titlesPosterUIImageView)
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let titlesPosterUIImageView = [titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView, constant: 15), titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView, constant: -15), titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate[titlesPosterUIImageView.]
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
}
