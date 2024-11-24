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
        setLogoImage()
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
    
    private func setLogoImage(){
        let urlString = "https://i.namu.wiki/i/NGxQfn1A-o9Hp3dJl7_iDPTg_ZNRfG3o5_w1HAHm5BzOilYdp1uiZWJuo5R9liEAnllTvSMBxxY0e91Y6N9-ZQ.svg"
        
        loginView.imgView.kf.setImage(with: URL(string: urlString), placeholder: UIImage(systemName: "antenna.radiowaves.left.and.right.slash")?.withTintColor(.black))
    }
}
