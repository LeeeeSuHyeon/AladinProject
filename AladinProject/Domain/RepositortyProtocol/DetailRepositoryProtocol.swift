//
//  DetailRepositoryProtocol.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import Foundation

public protocol DetailRepositoryProtocol {
    func saveFavoriteItem(item : Product) -> Result<Bool, CoreDataError>
    func deleteFavoriteItem(id : String) -> Result<Bool, CoreDataError>
    func checkFavoriteItem(id : String) -> Result<Bool, CoreDataError>
    func fetchItem(id : String) async -> Result<ProductResult, NetworkError>
}
