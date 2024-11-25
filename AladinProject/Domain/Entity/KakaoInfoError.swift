//
//  KakaoInfoError.swift
//  AladinProject
//
//  Created by 이수현 on 11/25/24.
//

import Foundation

public enum KakaoInfoError : Error {
    case readUserInfoError
    case userInfoResponseError
    case kakaoAccountError
    case infoEmptyError
    var description : String {
        switch self {
        case .readUserInfoError:
            "사용자 정보 읽기 실패"
        case .kakaoAccountError:
            "사용자 계정 오류"
        case .infoEmptyError:
            "정보가 없습니다."
        case .userInfoResponseError:
            "사용자 정보 가져오기 응답 없음"
        }
    }
}
