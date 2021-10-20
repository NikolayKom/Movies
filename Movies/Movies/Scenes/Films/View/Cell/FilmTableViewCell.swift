//
//  FilmTableViewCell.swift
//  Movies
//
//  Created by Николай on 03.10.2021.
//

import UIKit

final class FilmTableViewCell: UITableViewCell {
	
	static let identifier = "FilmTableViewCell"
    
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		return label
	}()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let localizedNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
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
		titleLabel.text = nil
        ratingLabel.text = nil
        localizedNameLabel.text = nil
	}
	
	func configure(item: FilmTableViewCellItem) {
		titleLabel.text = item.title
        localizedNameLabel.text = item.localizedTitle
        
        if let text = item.rating {
        ratingLabel.text = "\(String(describing: text))"
            
            if let rating = item.rating {
                ratingLabel.changeColorBy(rating: rating)
            }
        }
	}
	
	private func setup() {
		addSubview(titleLabel)
        addSubview(ratingLabel)
        addSubview(localizedNameLabel)
	}
	
    private func setupConstraints() {
        NSLayoutConstraint.useAndActivateConstraints([
            localizedNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            localizedNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            localizedNameLabel.rightAnchor.constraint(equalTo: ratingLabel.leftAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: localizedNameLabel.bottomAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            ratingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            ratingLabel.leftAnchor.constraint(equalTo: localizedNameLabel.rightAnchor),
            ratingLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
}
