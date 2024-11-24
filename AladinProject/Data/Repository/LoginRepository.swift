//
//  LoginRepository.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

public class LoginRepository : LoginRepositoryProtocol {
    private var isError : (Bool, KakaoLoginError)?

    public func kakaoLogin() -> Result<Bool, KakaoLoginError> {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoAccount { oauthToken, erorr in
                if let error = erorr {
                    print("loginWithKakaoAccount - error")
                    self.isError = (false, KakaoLoginError.loginFailed)
                } else {
                    // 토큰 저장
                    
                }
            }
            if let isError = isError {
                return .failure(isError.1)
            } else {
                return .success(true)
            }
        } else {
            return .failure(.loginUnavailable)
        }
    }
}
