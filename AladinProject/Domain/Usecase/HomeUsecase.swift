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
    func searchBook(query : String) async -> Result<BookResult, NetworkError>
    func fetchNewBookList() async -> Result<BookResult, NetworkError>
    func fetchBestSellerList() async -> Result<BookResult, NetworkError>
    func searchRecord() -> Result<[String], CoreDataError> // 검색 텍스트 필드 이전 검색 기록
}

class HomeUsecase : HomeUsecaseProtocol {
    let repository : HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    func searchBook(query: String) async -> Result<BookResult, NetworkError> {
        await repository.searchBook(query: query)
    }
    
    func fetchNewBookList() async -> Result<BookResult, NetworkError> {
        return await repository.fetchNewBookList()
    }
    func fetchBestSellerList() async -> Result<BookResult, NetworkError> {
        return await repository.fetchBestSellerList()
    }
    
    func searchRecord() -> Result<[String], CoreDataError> {
        repository.searchRecord()
    }
    
    
}
