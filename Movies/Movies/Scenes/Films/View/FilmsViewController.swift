//
//  ViewController.swift
//  projectMovies
//
//  Created by Николай on 02.10.2021.
//

import UIKit

protocol FilmsViewController: AnyObject {
	
	func reloadTableView()
	func showAlert(title: String, message: String)
    func showActivityIndicator()
    func hideActivityIndicator()
}

final class FilmsViewControllerImp: UIViewController, FilmsViewController {
	
	var presenter: FilmsPresenter?
    let myActivityIndicator = UIActivityIndicatorView()
    
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = .white
		tableView.tableFooterView = UIView()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
		return tableView
	}()
    
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		setupConstraints()
		presenter?.loadData()
	}
    
	private func setup() {
		title = "Фильмы"
		view.backgroundColor = .white
		view.addSubview(tableView)
	}
    
    func showActivityIndicator() {
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = true
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.myActivityIndicator.stopAnimating()
        }
    }
	
	func reloadTableView() {
		DispatchQueue.main.async { [weak self] in
			self?.tableView.reloadData()
		}
	}
    
	func showAlert(title: String, message: String) {
		let alertController = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert
		)
		alertController.addAction(.init(title: "OK", style: .cancel, handler: nil))
		present(alertController, animated: true, completion: nil)
	}
    private func setupConstraints() {
        NSLayoutConstraint.useAndActivateConstraints([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
// MARK: - UITableViewDataSource implementation

extension FilmsViewControllerImp: UITableViewDataSource  {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return presenter?.filmSections.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter?.filmSections[section].filmItems.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let item = presenter?.filmSections[indexPath.section].filmItems[indexPath.row],
			  let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath)
				as? FilmTableViewCell else { return UITableViewCell() }
		cell.configure(item: item)
		return cell
	}
}

// MARK: - UITableViewDelegate implementation

extension FilmsViewControllerImp: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard let year = presenter?.filmSections[section].year else { return nil }
		return "\(String(describing: year)) г."
	}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let film = presenter?.filmSections[indexPath.section].filmItems[indexPath.item] else { return }
        presenter?.openDetailFilm(film: film)
    }
}
