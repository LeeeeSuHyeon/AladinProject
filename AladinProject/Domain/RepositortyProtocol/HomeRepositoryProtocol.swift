//
//  HomeRespositoryProtocol.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import Foundation

public protocol HomeRepositoryProtocol {
    func searchBook(query : String) async -> Result<ProductResult, NetworkError>
    func fetchNewBookList() async -> Result<ProductResult, NetworkError>
    func fetchBestSellerList() async -> Result<ProductResult, NetworkError>
    func searchRecord() -> Result<[String], CoreDataError>
}

// http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbtngus06731717001&Query=채식주의자&output=JS
