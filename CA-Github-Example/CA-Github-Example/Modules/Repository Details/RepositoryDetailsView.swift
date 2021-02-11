//
//  RepositoryDetailsView.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import UIKit
import RxSwift

final class RepositoryDetailsView: UIView {
    private let presenter: RepositoryDetailsPresenterProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Elements

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0

        return label
    }()

    // MARK: - Init
    
    init(_ presenter: RepositoryDetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)

        backgroundColor = .white

        setupSubviews()
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

extension RepositoryDetailsView {
    private func setupBindings() {
        let input = RepositoryDetailsPresenter.Input()
        let output = presenter.buildOutput(with: input)

        disposeBag.insert(
            output.name.drive(titleLabel.rx.text),
            output.description.drive(descriptionLabel.rx.text)
        )
    }
}

private extension CGFloat {
    static let minSpacing: CGFloat = 15
    static let maxSpacing: CGFloat = 25

}
// MARK: - Private Methods
extension RepositoryDetailsView {
    
    private func setupSubviews() {
        addSubviews(titleLabel, descriptionLabel)
    }
    
    private func configureSubviews() {
        titleLabel.pin
            .top(pin.safeArea.top + .minSpacing)
            .horizontally(.minSpacing)
            .sizeToFit(.width)
        
        descriptionLabel.pin
            .below(of: titleLabel)
            .marginTop(.maxSpacing)
            .horizontally(.minSpacing)
            .sizeToFit(.width)
    }
}
