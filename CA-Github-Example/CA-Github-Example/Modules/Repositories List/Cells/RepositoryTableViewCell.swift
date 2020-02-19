//
//  RepositoryTableViewCell.swift
//  CA-Github-Example
//
//  Created by Nikita Velichkin on 19/02/2020.
//  Copyright © 2020 Nikita Velichkin. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell, ClassIdentifiable {

    // MARK: - UI Elements

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0

        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }

    func configure(with repository: Repository) {
        titleLabel.text = repository.name
    }
}

// MARK: - Private Methods

extension RepositoryTableViewCell {
    private func setupSubviews() {
        addSubviews(titleLabel)
    }

    private func configureSubviews() {
        titleLabel.configureFrame {
            $0.left().right().top().bottom()
        }
    }
}
