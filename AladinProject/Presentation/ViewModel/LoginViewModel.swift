//
//  LoginViewModel.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import Foundation
import RxSwift
import RxCocoa


public protocol LoginViewModelProtocol {
    func transform(input : LoginViewModel.Input) -> LoginViewModel.Output
}

public class LoginViewModel : LoginViewModelProtocol{
    
    private let usecase : LoginUsecaseProtocol
    private let error = PublishRelay<String>()
    private let isLoginSuccess = PublishRelay<Bool>()
    private let disposeBag = DisposeBag()
    
    
    init(usecase: LoginUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
        let tapKakaoLogin : Observable<Void>
    }
    
    public struct Output {
        let isLoginSuccess : Observable<Bool>
        let error : Observable<String>
    }
    
    public func transform(input : Input) -> Output {
        
        input.tapKakaoLogin.bind { [weak self] in
            self?.kakaoLogin()
        }.disposed(by: disposeBag)
        
        return Output(isLoginSuccess: isLoginSuccess.asObservable(), error: error.asObservable())
    }
    
    
    private func kakaoLogin(){
        let reuslt = usecase.kakaoLogin()
        switch reuslt {
        case .success(let success):
            self.isLoginSuccess.accept(true)
        case .failure(let error):
            self.error.accept(error.localizedDescription)
        }
    }
}
