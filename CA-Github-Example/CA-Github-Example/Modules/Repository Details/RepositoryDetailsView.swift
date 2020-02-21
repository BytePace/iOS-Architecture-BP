//
//  RepositoryDetailsView.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import UIKit
import RxSwift
import Framezilla

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

// MARK: - Private Methods

extension RepositoryDetailsView {
    
    private func setupSubviews() {
        addSubviews(titleLabel, descriptionLabel)
    }
    
    private func configureSubviews() {
        titleLabel.configureFrame {
            $0.top(to: nui_safeArea, inset: 25)
            $0.left(inset: 15).right(inset: 15)
            $0.bottom(to: descriptionLabel.nui_top, inset: 25)
        }

        descriptionLabel.configureFrame {
            $0.top(to: titleLabel.nui_bottom, inset: 25)
            $0.left(inset: 15).right(inset: 15)
            $0.heightToFit()
        }
    }
}
