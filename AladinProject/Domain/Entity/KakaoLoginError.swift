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
    case invalidTokenError // 현재 저장된 토큰이 유효하지 않은 경우
    case tokenOtherError // 토큰은 유효하나 다른 에러 (앱 에러, 인증 및 인가 에러, API 에러 등)
    
    var description : String {
        switch self {
        case .loginUnavailable:
            "카카오 로그인이 불가능합니다."
        case .loginFailed:
            "카카오 로그인에 실패했습니다."
        case .tokenError :
            "토큰이 없습니다."
        case .invalidTokenError:
            "토큰이 유효하지 않습니다."
        case .tokenOtherError:
            "토큰은 유효하나 인증, API 등 기타 에러"
        }
    
    }
}
