//
//  SeachSession.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import Foundation
import Alamofire


class SearchSession : SessionProtocol {
    
    let session : Session
    
    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        self.session = Session(configuration: config)
    }
    
    func request(_ convertible: any Alamofire.URLConvertible, method: Alamofire.HTTPMethod, parameters: Alamofire.Parameters?, headers: Alamofire.HTTPHeaders?) -> Alamofire.DataRequest {
        return session.request(convertible, method: method, parameters: parameters, headers: headers)
    }
    
    
}
