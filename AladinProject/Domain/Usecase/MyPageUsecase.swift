//
//  MyPageUsecase.swift
//  AladinProject
//
//  Created by 이수현 on 11/25/24.
//

import Foundation


public protocol MyPageUsecaseProtocol {
    func fetchUserInfo(completion : @escaping (Result<UserInfo, KakaoInfoError>) -> Void)
}


public class MyPageUsecase : MyPageUsecaseProtocol {
    
    private let repository : MyPageRepositoryProtocol
    
    init(repository: MyPageRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchUserInfo(completion: @escaping (Result<UserInfo, KakaoInfoError>) -> Void) {
        repository.fetchUserInfo { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
