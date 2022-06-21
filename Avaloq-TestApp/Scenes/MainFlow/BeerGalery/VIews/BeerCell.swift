//
//  BeerCell.swift
//  Avaloq-Libin_DevTest
//
//  Created by Sergey Libin on 09.06.2022.
//

import Foundation
import UIKit
import SDWebImage

final class BeerCell: UITableViewCell {
    
    static let reuseIdentifier = "BeerCell"
    
    // MARK: UI
    let beerImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [beerImageView, titleLabel, descriptionLabel].forEach(contentView.addSubview)
        setupConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model: BeerModel) {
        let url = URL(string: model.imageUrl)
        beerImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "empty_bottle"))
        titleLabel.text = model.tagline
        descriptionLabel.text = model.description
    }
    
    // MARK: Configuration
    private func setupConstraints() {
        beerImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            beerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            beerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            beerImageView.heightAnchor.constraint(equalToConstant: 100),
            beerImageView.widthAnchor.constraint(equalToConstant: 50),
            beerImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
