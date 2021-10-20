//
//  FilmDescriptionTableViewCell.swift
//  Movies
//
//  Created by Николай on 06.10.2021.
//

import UIKit

final class FilmDescriptionTableViewCell: UITableViewCell {
    
    static let identifier = "FilmDescriptionTableViewCell"
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
    }
    
    func configure(item: FilmTableViewCellItem) {
        descriptionLabel.text = item.description
        }
    
    private func setup() {
        addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.useAndActivateConstraints([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}

