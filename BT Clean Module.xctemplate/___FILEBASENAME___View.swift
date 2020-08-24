//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import PinLayout

final class ___VARIABLE_moduleName___View: UIView {
    private let presenter: ___VARIABLE_moduleName___PresenterProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Elements
    
    // MARK: - Lifecycle
    
    init(_ presenter: ___VARIABLE_moduleName___PresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        
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

extension ___VARIABLE_moduleName___View {
    private func setupBindings() {
        let input = ___VARIABLE_moduleName___Presenter.Input()
        let output = presenter.buildOutput(with: input)
    }
}

// MARK: - Private Methods

extension ___VARIABLE_moduleName___View {
    
    private func setupSubviews() {
        addSubviews()
    }
    
    private func configureSubviews() {
        
    }
}
