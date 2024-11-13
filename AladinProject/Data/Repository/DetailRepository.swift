//
//  DetailRepository.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import Foundation

public class DetailRepository : DetailRepositoryProtocol {
    
    let coreData : DetailCoreDataProtocol
    let network : DetailNetworkProtocol
    
    init(coreData: DetailCoreDataProtocol, network : DetailNetworkProtocol) {
        self.coreData = coreData
        self.network = network
    }
    
    public func saveFavoriteItem(item: Product) -> Result<Bool, CoreDataError> {
        return coreData.saveFavoriteItem(item: item)
    }
    
    public func deleteFavoriteItem(id: Int) -> Result<Bool, CoreDataError> {
        return coreData.deleteFavoriteItem(id: id)
    }
    
    public func fetchItem(id: String) async -> Result<ProductResult, NetworkError> {
        return await network.fetchItem(id: id)
    }
    
    
}
