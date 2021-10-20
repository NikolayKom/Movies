//
//  FilmDetailController.swift
//  projectMovies
//
//  Created by Николай on 02.10.2021.
//

import UIKit

protocol FilmDetailController: AnyObject {
    func reloadTableView()
}

final class FilmDetailControllerImp: UIViewController, FilmDetailController {
    
	var presenter: FilmDetailPresenter?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(FilmDetailTableViewCell.self, forCellReuseIdentifier: FilmDetailTableViewCell.identifier)
        tableView.register(FilmDescriptionTableViewCell.self, forCellReuseIdentifier: FilmDescriptionTableViewCell.identifier)
        return tableView
    }()
    
   private func setup() {
        view.backgroundColor = .white
        title = presenter?.filmTableViewCellItem.title
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.useAndActivateConstraints([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
}

// MARK: - UITableViewDataSource implementation

extension FilmDetailControllerImp: UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
        guard let cellInfo = tableView.dequeueReusableCell(withIdentifier: FilmDetailTableViewCell.identifier, for: indexPath)
                as? FilmDetailTableViewCell else { return UITableViewCell() }
            
            if let film = presenter?.filmTableViewCellItem {
                cellInfo.configure(item: film)
            }
            
        return cellInfo
            
        case 1:
        guard let cellDesctiption = tableView.dequeueReusableCell(withIdentifier: FilmDescriptionTableViewCell.identifier, for: indexPath)
                as? FilmDescriptionTableViewCell else { return UITableViewCell() }
            if let film = presenter?.filmTableViewCellItem {
                cellDesctiption.configure(item: film)
            }
        return cellDesctiption
            
        default:
            break
        }
    return UITableViewCell()
    }
}
