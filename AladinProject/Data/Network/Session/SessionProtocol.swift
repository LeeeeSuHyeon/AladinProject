//
//  SessionProtocol.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import Foundation
import Alamofire

public protocol SessionProtocol {
    func request(_ convertible: any URLConvertible,
                method: HTTPMethod,
                parameters: Parameters?,
                headers: HTTPHeaders?) -> DataRequest
}
