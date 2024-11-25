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
        
        self.hasKakaoToken {[weak self] result in
            switch result {
            case .success(let hasToken):
                if hasToken {
                    print("Token 유효")
                    self?.isLoginSuccess.accept(true)
                } else {
                    UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                        if let error = error {
                            print("loginWithKakaoAccount - \(error)")
                            self?.error.accept(KakaoLoginError.loginFailed.description)
                        } else {
                            // 토큰 저장
                            guard let token = oauthToken else {
                                print("token Error")
                                self?.error.accept(KakaoLoginError.tokenError.description)
                                return
                            }
                            let status = KeychainService.shared.save(account: .my, service: .kakaoLogin, value: token.accessToken)
                            if status == errSecSuccess {
                                print("KakaoLoginToken - Saved")
                                self?.isLoginSuccess.accept(true)
                            } else {
                                // 키 체인 에러
                            }
                        }
                    }
                }
            case .failure(let error):
                self?.error.accept(error.description)
            }
        }
    }
    
    private func hasKakaoToken(completion: @escaping (Result<Bool, KakaoLoginError>) -> Void) {
        if (AuthApi.hasToken()) { // 토큰이 있다면
            UserApi.shared.accessTokenInfo { ( _ , error) in // 토큰 정보 불러오기
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        // 토큰이 유효하지 않은 경우
                        //로그인 필요
                        completion(.success(false))
                    }
                    else {
                        //기타 에러
                        completion(.failure(.tokenOtherError))
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    completion(.success(true))
                }
            }
        }
        else { // 토큰이 없다면
            //로그인 필요
            completion(.success(false))
        }
    }
}
