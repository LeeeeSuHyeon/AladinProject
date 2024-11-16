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
    
    func fetchNewBookList() async -> Result<ProductResult, NetworkError> {
        return await network.fetchProductList(type: .itemNewAll)
    }
    
    func fetchBestSellerList() async -> Result<ProductResult, NetworkError> {
        return await network.fetchProductList(type: .bestSeller)
    }
}
