//
//  BaseView.swift
//  TestGithubProject
import UIKit
import RxSwift

class BaseView: UIView {
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupSubviews()
        setupBindings()
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(frame: .zero)
    }
    
    func setupSubviews() { }
    
    func setupBindings() { }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
    
    func configureSubviews() { }
}
