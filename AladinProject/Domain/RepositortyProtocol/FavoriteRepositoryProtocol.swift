//
//  FavoriteRepositoryProtocol.swift
//  AladinProject
//
//  Created by 이수현 on 11/19/24.
//

import Foundation

public protocol FavoriteRepositoryProtocol {
    func fetchFavoriteItem() -> Result<[FavoriteItem], CoreDataError>
    func deleteFavoriteItem(id : String) -> Result<Bool, CoreDataError>
}


public class FavoriteRepository : FavoriteRepositoryProtocol {
    
    private let coreData : FavoriteCoreDataProtocol
    
    init(coreData: FavoriteCoreDataProtocol) {
        self.coreData = coreData
    }
    
    public func fetchFavoriteItem() -> Result<[FavoriteItem], CoreDataError> {
        coreData.fetchFavoriteItem()
    }
    
    public func deleteFavoriteItem(id: String) -> Result<Bool, CoreDataError> {
        coreData.deleteFavoriteItem(id: id)
    }
    
    
}
