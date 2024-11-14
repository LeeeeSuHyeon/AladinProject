//
//  DetailNetwork.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import Foundation

public protocol DetailNetworkProtocol {
    func fetchItem(id : String) async -> Result<ProductResult, NetworkError>
}

public class DetailNetwork : DetailNetworkProtocol {
    let manager : NetworkManagerProtocol
    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }
    
    public func fetchItem(id: String) async -> Result<ProductResult, NetworkError> {
        let key = Bundle.main.infoDictionary?["APIKey"] as? String ?? ""
        let url = "ItemLookUp.aspx?ttbkey=\(key)&itemIdType=ISBN&itemId=\(id)&output=JS&Version=20131101"
        
        return await manager.fetchData(url: url, method: .get, parameters: nil, headers: nil)
    }
    
    
}

//http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?ttbkey=[TTBKey]&itemIdType=ISBN&ItemId=[도서의ISBN]&output=xml&Version=20131101&OptResult=ebookList,usedList,reviewList
