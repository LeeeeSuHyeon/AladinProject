//
//  LoginRepositoryProtocol.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import UIKit

public protocol LoginRepositoryProtocol {
    func kakaoLogin() -> Result<Bool, Error>
}

