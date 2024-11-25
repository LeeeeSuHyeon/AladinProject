//
//  LoginUsecase.swift
//  AladinProject
//
//  Created by 이수현 on 11/25/24.
//

import Foundation

public protocol LoginUsecaseProtocol {
    func kakaoLogin(completion : @escaping (Result<Bool, KakaoLoginError>) -> Void)
}

public class LoginUsecase : LoginUsecaseProtocol {
    private let repository : LoginRepositoryProtocol
    init(repository: LoginRepositoryProtocol) {
        self.repository = repository
    }
    
    public func kakaoLogin(completion: @escaping (Result<Bool, KakaoLoginError>) -> Void) {
        repository.kakaoLogin { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
