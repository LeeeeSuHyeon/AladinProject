//
//  DetailRepository.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import Foundation

public class DetailRepository : DetailRepositoryProtocol {
    
    let coreData : DetailCoreDataProtocol
    
    init(coreData: DetailCoreDataProtocol) {
        self.coreData = coreData
    }
    
    public func saveFavoriteItem(item: Product) -> Result<Bool, CoreDataError> {
        coreData.saveFavoriteItem(item: item)
    }
    
    public func deleteFavoriteItem(id: Int) -> Result<Bool, CoreDataError> {
        coreData.deleteFavoriteItem(id: id)
    }
    
}
