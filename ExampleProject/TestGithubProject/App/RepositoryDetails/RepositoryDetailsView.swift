//
//  RepositoryDetailsView.swift
//  TestGithubProject
//

//

import UIKit
import Foundation
import RxSwift
import RxCocoa

private extension CGFloat {
    
    static let avatarTopMargin: CGFloat = 30
    
    static let avatarSize: CGFloat = 120
    
    static let repoNameTopMargin: CGFloat = 30
    
    static let labelVerticalSpacing: CGFloat = 20
    
    static let labelHorizontalMargin: CGFloat = 10
    
    static let dateLabelsHorizontalSpacing: CGFloat = 20
    
}

final class RepositoryDetailsView: BaseView {
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private let avatarView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = nil
        
        imageView.backgroundColor = .gray
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = .avatarSize / 2.0
        
        return imageView
    }()

    private let repoName: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 13)
        label.contentMode = .center
        label.textAlignment = .center
        
        label.numberOfLines = 0
        
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private let readmeLabel: UITextView = {
        let textView = UITextView()
        
        textView.font = .systemFont(ofSize: 12)
        textView.isScrollEnabled = false
        
        textView.isEditable = false
        
        return textView
    }()
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    private let updatedAtLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    fileprivate let linkPressed: PublishRelay<URL> = .init()
    
    var repository: GithubRepository? = nil {
        didSet {
            updateUI()
        }
    }
    
    var readme: String = "" {
        didSet {
            updateUI()
        }
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        return formatter
    }()
    
    private func updateUI() {
        avatarView.setImageUrl(repository?.owner.avatarUrl)
        
        repoName.text = repository?.fullName
        
        descriptionLabel.text = repository?.description
        
        languageLabel.text = "Language: %@".localizedWithFormat(repository?.language ?? "None".localized)
        
        readmeLabel.text = nil
        
        if let readmeData = readme.data(using: .utf8) {
            readmeLabel.attributedText = try? NSAttributedString(
                data: readmeData,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
        }
        
        var createdAtString = "Unknown".localized
        
        if let createdAt = repository?.createdAt {
            createdAtString = Self.dateFormatter.string(from: createdAt)
        }
        
        createdAtLabel.text = "Created at: %@".localizedWithFormat(createdAtString)
        
        var updatedAtString = "Unknown".localized
        
        if let updatedAt = repository?.updatedAt {
            updatedAtString = Self.dateFormatter.string(from: updatedAt)
        }
        
        updatedAtLabel.text = "Updated at: %@".localizedWithFormat(updatedAtString)
        
        setNeedsLayout()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        backgroundColor = .white
        
        readmeLabel.delegate = self
        
        addSubviews(scrollView)
        
        scrollView.addSubviews(avatarView,
                               repoName,
                               descriptionLabel,
                               languageLabel,
                               readmeLabel,
                               createdAtLabel,
                               updatedAtLabel)
    }
    
    override func configureSubviews() {
        scrollView.pin
            .all(pin.safeArea)
        
        avatarView.pin
            .size(.avatarSize)
            .top(.avatarTopMargin)
            .hCenter()
        
        repoName.pin
            .below(of: avatarView)
            .marginTop(.repoNameTopMargin)
            .horizontally(.labelHorizontalMargin)
            .sizeToFit(.width)
        
        descriptionLabel.pin
            .below(of: repoName)
            .marginTop(.labelVerticalSpacing)
            .horizontally(.labelHorizontalMargin)
            .sizeToFit(.width)
        
        languageLabel.pin
            .below(of: descriptionLabel)
            .marginTop(.labelVerticalSpacing)
            .horizontally(.labelHorizontalMargin)
            .sizeToFit(.width)
        
        createdAtLabel.pin
            .below(of: languageLabel)
            .marginTop(.labelVerticalSpacing)
            .left(.labelHorizontalMargin)
            .right(to: edge.hCenter)
            .sizeToFit(.width)
        
        updatedAtLabel.pin
            .below(of: languageLabel)
            .marginTop(.labelVerticalSpacing)
            .left(to: edge.hCenter)
            .right(.labelVerticalSpacing)
            .sizeToFit(.width)
        
        readmeLabel.pin
            .below(of: updatedAtLabel)
            .marginTop(.labelVerticalSpacing)
            .horizontally(.labelHorizontalMargin)
            .sizeToFit(.width)
        
        scrollView.contentSize = .init(width: scrollView.bounds.width,
                                       height: readmeLabel.frame.maxY)
    }
}

extension RepositoryDetailsView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if interaction == .invokeDefaultAction {
            linkPressed.accept(URL)
        }
        
        return false
    }
}

extension Reactive where Base: RepositoryDetailsView {
    var repository: Binder<GithubRepository?> {
        .init(self.base) { view, repo in
            view.repository = repo
        }
    }
    
    var readme: Binder<String> {
        .init(self.base) { view, readme in
            view.readme = readme
        }
    }
    
    var onLinkTap: Observable<URL> {
        self.base.linkPressed.asObservable()
    }
}
