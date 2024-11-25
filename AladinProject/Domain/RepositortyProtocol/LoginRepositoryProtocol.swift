//
//  LoginRepositoryProtocol.swift
//  AladinProject
//
//  Created by 이수현 on 11/25/24.
//

import Foundation

public protocol LoginRepositoryProtocol {
    func kakaoLogin(completion : @escaping (Result<Bool, KakaoLoginError>) -> Void)
}
