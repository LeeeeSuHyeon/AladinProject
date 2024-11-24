//
//  LoginRepository.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import UIKit

public class LoginRepository : LoginRepositoryProtocol {

    public func kakaoLogin() -> Result<Bool, any Error> {
        .success(true)
    }
}
