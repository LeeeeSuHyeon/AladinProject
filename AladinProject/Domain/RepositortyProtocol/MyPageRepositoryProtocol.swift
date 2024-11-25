//
//  MyPageRepositoryProtocol.swift
//  AladinProject
//
//  Created by 이수현 on 11/25/24.
//

import Foundation


public protocol MyPageRepositoryProtocol {
    func fetchUserInfo(completion : @escaping (Result<UserInfo, KakaoInfoError>) -> Void)
}
