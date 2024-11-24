//
//  LoginUsecase.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import UIKit


public protocol LoginUsecaseProtocol {
    func kakaoLogin() -> Result<Bool, KakaoLoginError>
}

public class LoginUsecase : LoginUsecaseProtocol {
    
    private let repository : LoginRepositoryProtocol
    
    init(repository: LoginRepositoryProtocol) {
        self.repository = repository
    }
    
    public func kakaoLogin() -> Result<Bool, KakaoLoginError> {
        repository.kakaoLogin()
    }  
}
