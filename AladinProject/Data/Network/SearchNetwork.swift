//
//  SearchNetwork.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import Foundation

public protocol SearchNetworkProtocol {
    func searchBook(query : String, page : Int) async -> Result<ProductResult, NetworkError>
}

public class SearchNetwork : SearchNetworkProtocol{
    
    let manager : NetworkManagerProtocol
    
    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }
    
    public func searchBook(query: String, page : Int) async -> Result<ProductResult, NetworkError> {
        let allowedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let key = Bundle.main.infoDictionary?["APIKey"] as? String ?? ""
        let maxResults = 10
        let start = maxResults * (page - 1) + 1
        let url = "/ItemSearch.aspx?ttbkey=\(key)&Query=\(allowedQuery)&QueryType=Title&MaxResults=\(maxResults)&start=\(start)&SearchTarget=Book&output=JS&Version=20131101"
        
        return await manager.fetchData(url: url, method: .get, parameters: nil, headers: nil)
    }
}


/*
 http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=[TTBKey]&Query=aladdin&QueryType=Title&MaxResults=10&start=1&SearchTarget=Book&output=xml&Version=20131101
 */
