//
//  BeerGaleryViewController.swift
//  Avaloq-Libin_DevTest
//
//  Created by Sergey Libin on 09.06.2022.
//

import Foundation
import UIKit

protocol BeerGaleryViewControllerProtocol: AnyObject {
    func updateData(data: [BeerModel])
    func showError(message: String, completion: (() -> Void)?)
}

final class BeerGaleryViewController: UITableViewController {
    
    var presenter: BeerGaleryPresenterProtocol?
    
    private var tableViewData: [BeerModel] = []
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        
        configureViews()
    }
    
    // MARK: Configuration
    private func configureViews() {
        view.backgroundColor = .white
        
        tableView.register(BeerCell.self, forCellReuseIdentifier: BeerCell.reuseIdentifier)
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    // MARK: Actions
    @objc private func refresh(_ sender: AnyObject) {
        presenter?.reloadData()
    }
    
    // MARK: TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerCell.reuseIdentifier) as? BeerCell
        let data = tableViewData[indexPath.row]
        
        cell?.setup(model: data)
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableViewData.count - 1 {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            presenter?.loadNextPage()
        }
    }
}

// MARK: - BeerGaleryViewControllerProtocol
extension BeerGaleryViewController: BeerGaleryViewControllerProtocol {
    func updateData(data: [BeerModel]) {
        tableViewData = data
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func showError(message: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in completion?() }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
