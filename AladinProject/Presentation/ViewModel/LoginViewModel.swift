//
//  LoginViewModel.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import Foundation
import RxSwift
import RxCocoa
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon



public protocol LoginViewModelProtocol {
    func transform(input : LoginViewModel.Input) -> LoginViewModel.Output
}

public class LoginViewModel : LoginViewModelProtocol{
    
    private let error = PublishRelay<String>()
    private let isLoginSuccess = PublishRelay<Bool>()
    private let disposeBag = DisposeBag()
    
    public struct Input {
        let tapKakaoLogin : Observable<Void>
    }
    
    public struct Output {
        let isLoginSuccess : Observable<Bool>
        let error : Observable<String>
    }
    
    public func transform(input : Input) -> Output {
        
        input.tapKakaoLogin
            .observe(on: MainScheduler.instance)
            .bind { [weak self] in
                self?.kakaoLogin()
        }.disposed(by: disposeBag)
        
        return Output(isLoginSuccess: isLoginSuccess.asObservable(), error: error.asObservable())
    }
    
    
    private func kakaoLogin() {
        UserApi.shared.loginWithKakaoAccount { oauthToken, error in
            if let error = error {
                print("loginWithKakaoAccount - \(error)")
                self.error.accept(KakaoLoginError.loginFailed.description)
            } else {
                // 토큰 저장
                guard let token = oauthToken else {
                    print("token Error")
                    self.error.accept(KakaoLoginError.tokenError.description)
                    return
                }
                let status = KeychainService.shared.save(account: .my, service: .kakaoLogin, value: token.accessToken)
                if status == errSecSuccess {
                    print("KakaoLoginToken - Saved")
                    self.isLoginSuccess.accept(true)
                } else {
                    // 키 체인 에러
                }
            }
        }
    }
}
