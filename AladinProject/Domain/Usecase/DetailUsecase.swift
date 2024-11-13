//
//  DetailUsecase.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import Foundation


public protocol DetailUsecaseProtocol {
    func purchaseItem()
    func saveFavoriteItem(item : Product) -> Result<Bool, CoreDataError>
    func deleteFavoriteItem(id : Int) -> Result<Bool, CoreDataError>
    func linkItem(url : String)
}


public class DetailUsecase : DetailUsecaseProtocol {
    
    let repository : DetailRepositoryProtocol
    
    init(repository: DetailRepositoryProtocol) {
        self.repository = repository
    }
    
    public func purchaseItem() {
        print("DetailUsecase - purchaseItem()")
    }
    
    public func saveFavoriteItem(item: Product) -> Result<Bool, CoreDataError> {
        repository.saveFavoriteItem(item: item)
    }
    
    public func deleteFavoriteItem(id: Int) -> Result<Bool, CoreDataError> {
        repository.deleteFavoriteItem(id: id)
    }
    
    public func linkItem(url: String) {
        print("DetailUsecase - linkItem()")
    }
    
    
}
