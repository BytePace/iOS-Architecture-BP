//
//  RepositoriesListView.swift
//  TestGithubProject

//

import UIKit
import RxSwift
import PinLayout

final class RepositoriesListView: BaseView {
    
    // MARK: - UI Elements
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.autocorrectionType = .no
        
        searchBar.autocapitalizationType = .none
        
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.register(cellType: RepositoryTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        return refreshControl
    }()
    
    // MARK: - Lifecycle
    
    override func setupSubviews() {
        super.setupSubviews()
        
        backgroundColor = .white
        
        addSubviews(searchBar, tableView)
        
        tableView.refreshControl = refreshControl
    }
    
    override func configureSubviews() {
        super.configureSubviews()
        
        searchBar.pin
            .top(pin.safeArea)
            .horizontally(pin.safeArea)
            .height(.searchBarHeight)
        
        tableView.pin
            .below(of: searchBar)
            .horizontally(pin.safeArea)
            .bottom(pin.safeArea)
    }
}

// MARK: - Constants
private extension CGFloat {
    static let searchBarHeight: CGFloat = 60
}
