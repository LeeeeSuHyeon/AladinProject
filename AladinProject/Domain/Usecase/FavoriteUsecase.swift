//
//  FavoriteUsecase.swift
//  AladinProject
//
//  Created by 이수현 on 11/19/24.
//

import Foundation


public protocol FavoriteUsecaseProtocol {
    func fetchFavoriteItem() -> Result<[FavoriteItem], CoreDataError>
    func deleteFavoriteItem(id : String) -> Result<Bool, CoreDataError>
}


public class FavoriteUsecase : FavoriteUsecaseProtocol {
    
    private let repository : FavoriteRepositoryProtocol
    
    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    public func fetchFavoriteItem() -> Result<[FavoriteItem], CoreDataError> {
        repository.fetchFavoriteItem()
    }
    
    public func deleteFavoriteItem(id : String) -> Result<Bool, CoreDataError> {
        repository.deleteFavoriteItem(id : id)
    }
    
    
}
