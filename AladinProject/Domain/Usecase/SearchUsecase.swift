//
//  SearchUsecase.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import Foundation


public protocol SearchUsecaseProtocol {
    func searchBook(query : String) async -> Result<ProductResult, NetworkError>
    func searchRecord() -> Result<[String], CoreDataError> // 검색 텍스트 필드 이전 검색 기록
}


public class SearchUsecase : SearchUsecaseProtocol {
    
    let repository : SearchRepositoryProtocol
    
    init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }
    
    public func searchBook(query: String) async -> Result<ProductResult, NetworkError> {
        return await repository.searchBook(query: query)
    }
    
    public func searchRecord() -> Result<[String], CoreDataError> {
        repository.searchRecord()
    }
    
    
}
