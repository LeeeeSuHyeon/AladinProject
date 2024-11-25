//
//  LoginRepository.swift
//  AladinProject
//
//  Created by 이수현 on 11/25/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon


public class LoginRepository : LoginRepositoryProtocol{
    public func kakaoLogin(completion : @escaping (Result<Bool, KakaoLoginError>) -> Void) {
        hasKakaoToken { result in
            switch result {
            case .success(let hasToken):
                if hasToken { // 토큰이 있고 유효한 경우
                    completion(.success(true)) // 바로 로그인
                } else { // 토큰이 없어서 로그인이 필요한 경우
                    UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                        if let error = error { // 로그인 실패
                            print(error.localizedDescription)
                            completion(.failure(KakaoLoginError.loginFailed))
                        } else { // 에러 없을 때
                            guard let token = oauthToken else { // 토큰을 제대로 받았는지
                                completion(.failure(KakaoLoginError.tokenError))
                                return
                            }
                            // 키체인 저장
                            let status = KeychainService.shared.save(account: .my, service: .kakaoLogin, value: token.accessToken)
                            
                            if status == errSecSuccess { // 키체인 저장 성공
                                completion(.success(true))
                            } else {
                                // 키 체인 에러
                            }
                        }
                    }
                }
            case .failure(let error): // 에러 넘김
                completion(.failure(error))
            }
        }
    }
    private func hasKakaoToken(completion : @escaping (Result<Bool, KakaoLoginError>) -> Void) {
        if AuthApi.hasToken() { // 토큰이 있다면
            UserApi.shared.accessTokenInfo { _, error in // 토큰 정보 불러오기
                if let sdkError = error as? SdkError {
                    if sdkError.isInvalidTokenError(){
                        // 토큰이 유효하지 않을 때 (로그인 필요)
                        print("Token 유효")
                        completion(.success(false))
                    } else {
                        // 토큰 유효기간 에러가 아닌 다른 에러
                        completion(.failure(.tokenOtherError))
                    }
                } else {
                    // 토큰 정보가 있는 경우 로그인 성공
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    completion(.success(true))
                }
            }
        } else { // 토큰이 없는 경우
            // 토큰이 없는 경우 (로그인 필요)
            completion(.success(false))
        }
    }
}
