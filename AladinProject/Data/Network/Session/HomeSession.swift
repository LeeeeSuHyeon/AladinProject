//
//  HomeSession.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import Foundation
import Alamofire



class HomeSession : SessionProtocol{
    private var session : Session
    
    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        self.session = Session(configuration: config)
    }
    
    func request(_ convertible: any URLConvertible,
                method: HTTPMethod = .get,
                parameters: Parameters? = nil,
                headers: HTTPHeaders? = nil) -> DataRequest {
        return session.request(convertible, method: method, parameters: parameters, headers: headers)
    }
}
