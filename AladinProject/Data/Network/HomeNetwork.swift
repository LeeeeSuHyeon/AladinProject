//
//  HomeNetwork.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import Foundation
// 상품 검색, 상품 리스트 url이 다름 -> 응답 값은 동일
public protocol HomeNetworkProtocol {
    func fetchProductList(type : queryType) async -> Result<ProductResult, NetworkError>
}

final class HomeNetwork : HomeNetworkProtocol {
    private let manage : NetworkManagerProtocol
    
    init(manage: NetworkManagerProtocol) {
        self.manage = manage
    }
    
    func fetchProductList(type: queryType) async -> Result<ProductResult, NetworkError> {
        let key = Bundle.main.infoDictionary?["APIKey"] as? String ?? ""
        let url = "/ItemList.aspx?ttbkey=\(key)&QueryType=\(type)"
        let target = "Book"
        let query = "&MaxResult=10&start=1&SearchTarget=\(target)&output=JS&Version=20131101"
        return await manage.fetchData(url: url + query, method: .get, parameters: nil, headers: nil)
    }
}


// 상품 리스트
// http://www.aladin.co.kr/ttb/api/ItemList.aspx
// http://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=[TTBKey]&QueryType=ItemNewAll&MaxResults=10&start=1&SearchTarget=Book&output=xml&Version=20131101


/*
 QueryType
 ItemNewAll : 신간 전체 리스트
 ItemNewSpecial : 주목할 만한 신간 리스트
 ItemEditorChoice : 편집자 추천 리스트
 (카테고리로만 조회 가능 - 국내도서/음반/외서만 지원)
 Bestseller : 베스트셀러
 BlogBest : 블로거 베스트셀러 (국내도서만 조회 가능)
 */
