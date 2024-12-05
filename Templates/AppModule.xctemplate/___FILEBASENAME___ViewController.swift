import UIKit

final class ___VARIABLE_moduleName___ViewController: UIViewController {
    private let _view: ___VARIABLE_moduleName___View
    private let presenter: ___VARIABLE_moduleName___Presenter

    init(_ presenter: ___VARIABLE_moduleName___Presenter) {
        _view = ___VARIABLE_moduleName___View()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = _view
    }
}

extension ___VARIABLE_moduleName___ViewController {
    private func setupBindings() {}
}
