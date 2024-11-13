//
//  DetailCoreData.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import Foundation

public protocol DetailCoreDataProtocol {
    func saveFavoriteItem(item : Product) -> Result<Bool, CoreDataError>
    func deleteFavoriteItem(id : Int) -> Result<Bool, CoreDataError>
}

class DetailCoreData {
    
}
