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
        self.viewModel = LoginViewModel()
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
        
        output.isLoginSuccess
            .observe(on: MainScheduler.instance)
            .filter{$0} // 성공한 경우만
            .bind {[weak self] _ in
                let nextVC = TabBarController()
                nextVC.modalPresentationStyle = .fullScreen
                self?.present(nextVC, animated: true)
        }.disposed(by: disposeBag)
        
        output.error.bind { error in
            print("kakaoLoginError : \(error)")
        }.disposed(by: disposeBag)
    }
    
    private func setLogoImage(){
        let urlString = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShpfasHADn3excKHKNJonJhtmdCOOcVQ5v4w&s"
        
        loginView.imgView.kf.setImage(with: URL(string: urlString), placeholder: UIImage(systemName: "antenna.radiowaves.left.and.right.slash")?.withTintColor(.black))
    }
}
