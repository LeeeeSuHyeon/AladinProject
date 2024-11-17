//
//  DetailUsecase.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import Foundation


public protocol DetailUsecaseProtocol {
    func saveFavoriteItem(item : Product) -> Result<Bool, CoreDataError>
    func deleteFavoriteItem(id : String) -> Result<Bool, CoreDataError>
    func checkFavoriteItem(id : String) -> Result<Bool, CoreDataError>
    func fetchItem(id : String) async -> Result<ProductResult, NetworkError>
}


public class DetailUsecase : DetailUsecaseProtocol {
    let repository : DetailRepositoryProtocol
    
    init(repository: DetailRepositoryProtocol) {
        self.repository = repository
    }
    
    public func saveFavoriteItem(item: Product) -> Result<Bool, CoreDataError> {
        repository.saveFavoriteItem(item: item)
    }
    
    public func deleteFavoriteItem(id: String) -> Result<Bool, CoreDataError> {
        repository.deleteFavoriteItem(id: id)
    }
    
    public func checkFavoriteItem(id: String) -> Result<Bool, CoreDataError> {
        repository.checkFavoriteItem(id: id)
    }
    
    public func fetchItem(id : String) async -> Result<ProductResult, NetworkError> {
        await repository.fetchItem(id: id)
    }
    
    
    
}
