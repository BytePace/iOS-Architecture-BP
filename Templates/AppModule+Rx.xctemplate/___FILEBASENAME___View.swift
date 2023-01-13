//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift

final class ___VARIABLE_moduleName___View: UIView {
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Elements
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
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
