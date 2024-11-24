//
//  LoginViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private let loginView : LoginView
    private let viewModel : LoginViewModelProtocol
    private let tapKakaoLogin = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    init() {
        let loginRP = LoginRepository()
        let loginUC = LoginUsecase(repository: loginRP)
        self.viewModel = LoginViewModel(usecase: loginUC)
        self.loginView = LoginView()
        super.init(nibName: nil, bundle: nil)
        
        self.view = loginView
        bindView()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bindView(){
        loginView.btnKakaoLogin.rx.tap.bind { [weak self] in
            self?.tapKakaoLogin.accept(())
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel(){
        let output = viewModel.transform(input: LoginViewModel.Input(tapKakaoLogin: tapKakaoLogin.asObservable()))
        
        output.isLoginSuccess.bind { isSucess in
            let nextVC = TabBarController()
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }.disposed(by: disposeBag)
        
        output.error.bind { error in
            print("kakaoLoginError : \(error)")
        }.disposed(by: disposeBag)
    }
}
