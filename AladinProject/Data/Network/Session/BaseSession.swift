//
//  BaseSession.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import Alamofire
import Foundation

public class BaseSession : SessionProtocol {
    
    private let session : Session
    
    init(){
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        session = Session(configuration: config)
    }
    
    public func request(_ convertible: any Alamofire.URLConvertible, method: Alamofire.HTTPMethod, parameters: Alamofire.Parameters?, headers: Alamofire.HTTPHeaders?) -> Alamofire.DataRequest {
        session.request(convertible, method: method, parameters: parameters, headers: headers)
    }
    
    
}
