//
//  HomeUsecase.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import Foundation

public enum queryType : String {
    case itemNewAll = "ItemNewAll"
    case bestSeller = "Bestseller"
}

public protocol HomeUsecaseProtocol {
    func fetchNewBookList() async -> Result<ProductResult, NetworkError>
    func fetchBestSellerList() async -> Result<ProductResult, NetworkError>
    
}

class HomeUsecase : HomeUsecaseProtocol {
    let repository : HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchNewBookList() async -> Result<ProductResult, NetworkError> {
        return await repository.fetchNewBookList()
    }
    func fetchBestSellerList() async -> Result<ProductResult, NetworkError> {
        return await repository.fetchBestSellerList()
    }
}
