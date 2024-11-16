//
//  NetworkManage.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import Foundation
import Alamofire

public protocol NetworkManagerProtocol {
    func fetchData<T:Decodable>(url : String, method : HTTPMethod, parameters: Parameters?, headers : HTTPHeaders?) async -> Result<T, NetworkError>
}


public class NetworkManager : NetworkManagerProtocol {
    
    let session : SessionProtocol
    let baseURL = "https://www.aladin.co.kr/ttb/api"
    
    
    init(session: SessionProtocol) {
        self.session = session
    }
    
    public func fetchData<T : Decodable>(url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) async -> Result<T, NetworkError> {
        let requestURL = baseURL + url
        print(requestURL)
        guard let url = URL(string: requestURL) else { return .failure(.urlError)}
        let result = await session.request(url, method: method, parameters: parameters, headers: headers).serializingString().response
        if let error = result.error {
            return .failure(.requestFailed(error.localizedDescription))
        }
        guard let data = result.data else {return .failure(.dataNil)}
        guard let response = result.response else {return .failure(.invalidResponse)}
        if 200..<400 ~= response.statusCode {
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                return .success(data)
            } catch {
                return .failure(.failToDecode(error.localizedDescription))
            }
                
        } else {
            return .failure(.serverError(response.statusCode))
        }
    }
}
