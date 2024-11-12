//
//  HomeRespository.swift
//  AladinProject
//
//  Created by 이수현 on 11/12/24.
//

import Foundation

class HomeRespository : HomeRepositoryProtocol {

    let network : HomeNetworkProtocol
//    let coreData :
    
    init(network: HomeNetworkProtocol) {
        self.network = network
    }
    
    func searchBook(query: String) async -> Result<BookResult, NetworkError> {
        return .failure(.dataNil)
    }
    
    func fetchNewBookList() async -> Result<BookResult, NetworkError> {
        return await network.fetchBookList(type: .itemNewAll)
    }
    
    func fetchBestSellerList() async -> Result<BookResult, NetworkError> {
        return await network.fetchBookList(type: .bestSeller)
    }
    
    func searchRecord() -> Result<[String], CoreDataError> {
        return .failure(.deleteError(""))
    }
}
