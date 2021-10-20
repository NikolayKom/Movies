//
//  FilmDetailTableViewCell.swift
//  Movies
//
//  Created by Николай on 06.10.2021.
//

import UIKit

final class FilmDetailTableViewCell: UITableViewCell {
    
    static let identifier = "FilmDetailTableViewCell"
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let localizeNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ratingLabel.text = nil
        yearLabel.text = nil
        localizeNameLabel.text = nil
        logoImage.image = nil
    }
    
    func configure(item: FilmTableViewCellItem) {
        if let rating = item.rating, let stringUrl = item.imageUrl {
        ratingLabel.text = "Рейтинг: \(String(describing: rating))"
        ratingLabel.changeColorBy(rating: rating)
            
         if let urlImage = URL(string: stringUrl) {
            logoImage.downloadImage(from: urlImage)
            }
        } else {
            logoImage.image = UIImage(named: "DefaultImage")
        }
        
        yearLabel.text = "Год: \(item.year)"
        localizeNameLabel.text = item.localizedTitle
    }
    
    private func setup() {
        addSubview(ratingLabel)
        addSubview(logoImage)
        addSubview(localizeNameLabel)
        addSubview(yearLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.useAndActivateConstraints([
            
            logoImage.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            logoImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            logoImage.widthAnchor.constraint(equalToConstant: 180),
            logoImage.heightAnchor.constraint(equalToConstant: 180),
            logoImage.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
            
            localizeNameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 50),
            localizeNameLabel.leftAnchor.constraint(equalTo: logoImage.rightAnchor, constant: 12),
            localizeNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

            yearLabel.topAnchor.constraint(equalTo: localizeNameLabel.bottomAnchor, constant: 8),
            yearLabel.leftAnchor.constraint(equalTo: logoImage.rightAnchor, constant: 12),
            yearLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

            ratingLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 8),
            ratingLabel.leftAnchor.constraint(equalTo: logoImage.rightAnchor, constant: 12),
            ratingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
