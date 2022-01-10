//
//  RepositoryTableViewCell.swift
//  TestGithubProject
import UIKit

private extension CGFloat {
    static let horizontalMargin: CGFloat = 5
    
    static let verticalMargin: CGFloat = 10
    
    static let verticalSpacing: CGFloat = 5
    
    static let avatarSize: CGFloat = 60
}

class RepositoryTableViewCell: UITableViewCell, ClassIdentifiable {
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.font = .preferredFont(forTextStyle: .footnote)
        
        return label
    }()
    
    private let repoNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        
        imageView.backgroundColor = .gray
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = .avatarSize / 2.0
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubviews(descriptionLabel, repoNameLabel, avatarImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
    
    func setModel(_ repo: GithubRepository) {
        repoNameLabel.text = repo.fullName
        
        descriptionLabel.text = repo.description
        
        avatarImage.setImageUrl(repo.owner.avatarUrl)
        
        setNeedsLayout()
    }
    
    private func configureSubviews() {
        avatarImage.pin
            .top(.verticalMargin)
            .left(.horizontalMargin)
            .size(.avatarSize)
        
        repoNameLabel.pin
            .top(.verticalMargin)
            .after(of: avatarImage)
            .marginLeft(.horizontalMargin)
            .right(.horizontalMargin)
            .sizeToFit(.width)
        
        descriptionLabel.pin
            .after(of: avatarImage)
            .marginLeft(.horizontalMargin)
            .right(.horizontalMargin)
            .below(of: repoNameLabel)
            .marginVertical(.verticalSpacing)
            .sizeToFit(.width)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        var fakeSize = size
        
        fakeSize.height = CGFloat.greatestFiniteMagnitude
        
        self.frame.size = fakeSize
        
        layoutSubviews()
        
        var fitSize = size
        
        let maxY = max(descriptionLabel.frame.maxY, avatarImage.frame.maxY)
        
        fitSize.height = maxY + .verticalMargin
        
        return fitSize
    }
}
