//
//  DetailRepositoryProtocol.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import Foundation

public protocol DetailRepositoryProtocol {
    func purchaseItem()
    func saveFavoriteItem(item : Product) -> Result<Bool, CoreDataError>
    func deleteFavoriteItem(id : Int) -> Result<Bool, CoreDataError>
    func linkItem(url : String)
}
