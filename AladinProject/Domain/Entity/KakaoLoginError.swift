//
//  KakaoLoginError.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import Foundation

public enum KakaoLoginError : Error {
    case loginUnavailable
    case loginFailed
    case tokenError
    
    var description : String {
        switch self {
        case .loginUnavailable:
            "카카오 로그인이 불가능합니다."
        case .loginFailed:
            "카카오 로그인에 실패했습니다."
        case .tokenError :
            "토큰이 없습니다."
        }
    
    }
}
