//
//  RepositoriesListViewController.swift
//  TestGithubProject

//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import RxDataSources

final class RepositoriesListViewController: BaseViewController<RepositoriesListView, RepositoriesListPresenter> {
    // MARK: - UI Bindings
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    override init(_ presenter: RepositoriesListPresenter) {
        super.init(presenter)
        
        navigationItem.rightBarButtonItem = .init(customView: activityIndicator)
        
        title = "Repositories".localized
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private typealias RepositorySection = SectionModel<String, GithubRepository>
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<RepositorySection> = {
        let dataSource = RxTableViewSectionedReloadDataSource<RepositorySection>(configureCell: configureCell)
        
        return dataSource
    }()
    
    private var configureCell: RxTableViewSectionedReloadDataSource<RepositorySection>.ConfigureCell {
        return { _, tableView, indexPath, repository -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withCellType: RepositoryTableViewCell.self, forIndexPath: indexPath)
            
            cell.setModel(repository)
            
            return cell
        }
    }
    
    private static let debounceInterval: RxTimeInterval = .milliseconds(1_500)

    override func setupBindings() {
        super.setupBindings()
        
        let searchBarText = _view.searchBar.rx.text.unwrap()
            .ignore("")
            .debounce(Self.debounceInterval, scheduler: MainScheduler.asyncInstance)
            .distinctUntilChanged()
        
        let refresh = _view.refreshControl.rx.controlEvent(.valueChanged)
            .map { _ in () }
            .withLatestFrom(searchBarText)
        
        let repositorySelected = _view.tableView.rx
            .modelSelected(GithubRepository.self)
            .asObservable()
        
        let input = RepositoriesListPresenter.Input(
            searchText: Observable.merge(searchBarText, refresh),
            openDetails: repositorySelected
        )
        
        let output = presenter.buildOutput(with: input)
        
        output.repositories
            .map { [RepositorySection(model: "", items: $0)] }
            .drive(_view.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.isLoading
            .drive { [unowned self] isLoading in
                if isLoading {
                    activityIndicator.startAnimating()
                } else {
                    activityIndicator.stopAnimating()
                    _view.refreshControl.endRefreshing()
                }
            }
            .disposed(by: disposeBag)
    }
}
