//
//  FavoriteCoreData.swift
//  AladinProject
//
//  Created by 이수현 on 11/19/24.
//

import UIKit
import CoreData

public protocol FavoriteCoreDataProtocol {
    func fetchFavoriteItem() -> Result<[FavoriteItem], CoreDataError>
    func deleteFavoriteItem(id : String) -> Result<Bool, CoreDataError>
}


public class FavoriteCoreData : FavoriteCoreDataProtocol {
    
    private let viewContext : NSManagedObjectContext?
    
    init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.viewContext = appDelegate?.persistentContainer.viewContext
    }
    
    public func fetchFavoriteItem() -> Result<[FavoriteItem], CoreDataError> {
        let fetchRequest = FavoriteItem.fetchRequest()
        
        do {
            let result = try viewContext?.fetch(fetchRequest)
            return .success(result ?? [])
        } catch  {
            return .failure(.readError(error.localizedDescription))
        }
    }
    
    public func deleteFavoriteItem(id: String) -> Result<Bool, CoreDataError> {
        let fetchRequest = FavoriteItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %s", id)
        
        do {
            let result = try viewContext?.fetch(fetchRequest)
            result?.forEach({ item in
                viewContext?.delete(item)
            })
            
            try viewContext?.save()
            return .success(true)
        } catch  {
            return .failure(.deleteError(error.localizedDescription))
        }
    }
}
