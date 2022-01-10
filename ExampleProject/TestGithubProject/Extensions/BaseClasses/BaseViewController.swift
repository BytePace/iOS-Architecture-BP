//
//  BaseViewController.swift
//  TestGithubProject
import UIKit
import RxSwift

class BaseViewController<View: UIView, Presenter: RxPresenter>: UIViewController {
    
    let presenter: Presenter
    
    var _view: View {
        get {
            view as! View // swiftlint:disable:this force_cast
        }
        set {
            view = newValue
        }
    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        hideKeyboardWhenTappedAround()
    }
    
    func setupBindings() { }
    
    override func loadView() {
        view = View()
    }
    
    init(_ presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
