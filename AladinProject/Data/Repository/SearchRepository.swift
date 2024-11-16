//
//  SearchRepository.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import Foundation


public class SearchRepository : SearchRepositoryProtocol {
    
    private let coreData : SearchCoreDataProtocol
    private let network : SearchNetworkProtocol
    
    init(coreData: SearchCoreDataProtocol, network: SearchNetworkProtocol) {
        self.coreData = coreData
        self.network = network
    }
    
    public func searchBook(query: String) async -> Result<ProductResult, NetworkError> {
        return await network.searchBook(query: query)
    }
    
    public func fetchSearchRecord() -> Result<[String], CoreDataError> {
        return coreData.fetchSearchRecord()
    }
    
    public func saveSearchRecord(title : String) -> Result<Bool, CoreDataError> {
        return coreData.saveSearchRecord(title : title)
    }
}
