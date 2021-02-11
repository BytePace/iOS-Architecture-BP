//
//  RepositoriesListView.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

final class RepositoriesListView: UIView {
    typealias RepoSection = SectionModel<String, Repository>

    private let presenter: RepositoriesListPresenterProtocol

    private var dataSource: RxTableViewSectionedReloadDataSource<RepoSection>!
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Elements

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.text = "RxSwift"

        return searchBar
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(cellType: RepositoryTableViewCell.self)

        return tableView
    }()

    // MARK: - Init
    
    init(_ presenter: RepositoriesListPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)

        backgroundColor = .white
        
        setupSubviews()
        setupDataSource()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
}

// MARK: - UI Bindings

extension RepositoriesListView {
    private func setupBindings() {
        let input = RepositoriesListPresenter.Input(
            searchText: searchBar.rx.text.orEmpty
                .filter { !$0.isEmpty }
                .distinctUntilChanged()
                .debounce(.seconds(1), scheduler: MainScheduler.instance)
                .asObservable(),
            repoSelected: tableView.rx.modelSelected(Repository.self).asObservable()
        )

        let output = presenter.buildOutput(with: input)

        disposeBag.insert(
            output.dataSource.drive(tableView.rx.items(dataSource: dataSource))
        )
    }
}

// MARK: - Private Methods

import PinLayout

private extension CGFloat {
    static let hSpacing: CGFloat = 12
    static let topSpacing: CGFloat = 20
    static let bottomSpacing: CGFloat = 8
}
extension RepositoriesListView {

    private func setupDataSource() {
        dataSource = .init(configureCell: configureCell)
    }

    private func setupSubviews() {
        addSubviews(searchBar, tableView)
    }
    
    private func configureSubviews() {
        searchBar.pin
            .top(pin.safeArea.top)
            .horizontally()
        
        tableView.pin
            .below(of: searchBar)
            .marginTop(.topSpacing)
            .horizontally(.hSpacing)
            .bottom(pin.safeArea.bottom + .bottomSpacing)
    }
}

// MARK: - Data Source Configuration

extension RepositoriesListView {
    private var configureCell: RxTableViewSectionedReloadDataSource<RepoSection>.ConfigureCell {
        return { _, tableView, indexPath, repository in
            let cell: RepositoryTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(with: repository)

            return cell
        }
    }
}
