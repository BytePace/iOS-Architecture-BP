//
//  RepositoryDetailsViewController.swift
//  TestGithubProject
//

//

import UIKit

final class RepositoryDetailsViewController: BaseViewController<RepositoryDetailsView, RepositoryDetailsPresenter> {
    // MARK: - UI Bindings
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        return indicator
    }()
    
    override init(_ presenter: RepositoryDetailsPresenter) {
        super.init(presenter)
        
        navigationItem.rightBarButtonItem = .init(customView: activityIndicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupBindings() {
        super.setupBindings()
        
        let input = RepositoryDetailsPresenter.Input(
            linkTap: _view.rx.onLinkTap
        )
        let output = presenter.buildOutput(with: input)
        
        output.repository
            .drive(_view.rx.repository)
            .disposed(by: disposeBag)
        
        output.repository
            .map { $0.fullName }
            .drive(self.rx.title)
            .disposed(by: disposeBag)
        
        output.readme
            .drive(_view.rx.readme)
            .disposed(by: disposeBag)
        
        output.isLoading
            .drive { [unowned self] isLoading in
                if isLoading {
                    activityIndicator.startAnimating()
                } else {
                    activityIndicator.stopAnimating()
                }
            }
            .disposed(by: disposeBag)
    }
}
