//
//  MyPageRepository.swift
//  AladinProject
//
//  Created by 이수현 on 11/25/24.
//

import Foundation
import KakaoSDKUser

public class MyPageRepository : MyPageRepositoryProtocol {
    public func fetchUserInfo(completion: @escaping (Result<UserInfo, KakaoInfoError>) -> Void) {
        UserApi.shared.me { User, error in
            if let error = error {
                print("shared Error : \(error)")
                completion(.failure(.readUserInfoError))
            } else {
                guard let user = User else {
                    completion(.failure(.userInfoResponseError))
                    return
                }
                guard let kakaoAccount = user.kakaoAccount else {
                    completion(.failure(.kakaoAccountError))
                    return
                }
                
                let userInfo = UserInfo(profileImage: kakaoAccount.profile?.thumbnailImageUrl, nickname: kakaoAccount.profile?.nickname ?? "닉네임 없음", account: kakaoAccount.email ?? "이메일 없음")
                completion(.success(userInfo))
            }
        }
    }
    
}
