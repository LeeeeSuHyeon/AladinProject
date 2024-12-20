//
//  SearchUsecase.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import Foundation


public protocol SearchUsecaseProtocol {
    func searchBook(query : String, page : Int) async -> Result<ProductResult, NetworkError>
    func fetchSearchRecord() -> Result<[String], CoreDataError> // 검색 텍스트 필드 이전 검색 기록
    func saveSearchRecord(title : String) -> Result<Bool, CoreDataError>
    func deleteSearchRecord(title : String) -> Result<Bool, CoreDataError>
    func deleteAllSearchRecord() -> Result<Bool, CoreDataError>
}


public class SearchUsecase : SearchUsecaseProtocol {

    let repository : SearchRepositoryProtocol
    
    init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }
    
    public func searchBook(query: String, page : Int) async -> Result<ProductResult, NetworkError> {
        await repository.searchBook(query: query, page : page)
    }
    
    public func fetchSearchRecord() -> Result<[String], CoreDataError> {
        repository.fetchSearchRecord()
    }
    
    public func saveSearchRecord(title : String) -> Result<Bool, CoreDataError> {
        repository.saveSearchRecord(title : title)
    }
    
    public func deleteSearchRecord(title: String) -> Result<Bool, CoreDataError> {
        repository.deleteSearchRecord(title: title)
    }
    
    public func deleteAllSearchRecord() -> Result<Bool, CoreDataError> {
        repository.deleteAllSearchRecord()
    }
    

}
