//
//  DetailCoreData.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import UIKit
import CoreData


public protocol DetailCoreDataProtocol {
    func saveFavoriteItem(item : Product) -> Result<Bool, CoreDataError>
    func deleteFavoriteItem(id : String) -> Result<Bool, CoreDataError>
    func checkFavoriteItem(id: String) -> Result<Bool, CoreDataError>
}

public struct DetailCoreData : DetailCoreDataProtocol {

    private var viewContext : NSManagedObjectContext?
    
    init(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        self.viewContext = appDelegate.persistentContainer.viewContext
    }

    public func saveFavoriteItem(item: Product) -> Result<Bool, CoreDataError> {
        guard let viewContext = viewContext,
                let entity = NSEntityDescription.entity(forEntityName: "FavoriteItem", in: viewContext)
        else { return .failure(.entityNotFound("FavoriteItem"))}
        let object = NSManagedObject(entity: entity , insertInto: viewContext)
        
        object.setValue(item.author, forKey: "author")
        object.setValue(item.coverURL, forKey: "imageURL")
        object.setValue(item.title, forKey: "title")
        object.setValue(item.id, forKey: "id")
        object.setValue(item.type, forKey: "type")
        
        do {
            try viewContext.save()
            return .success(true)
        } catch {
            return .failure(.saveError(error.localizedDescription))
        }
    }
    
    public func deleteFavoriteItem(id: String) -> Result<Bool, CoreDataError> {
        let fetchRequest : NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try viewContext?.fetch(fetchRequest)
            result?.forEach({ item in
                viewContext?.delete(item)
            })
            try viewContext?.save()
            return .success(true)
        } catch {
            return .failure(.deleteError(error.localizedDescription))
        }
    }
    
    public func checkFavoriteItem(id: String) -> Result<Bool, CoreDataError> {
        let fetchRequest = FavoriteItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try viewContext?.fetch(fetchRequest)
            if let result = result, result.count > 0 {
                return .success(true)
            } else {
                return .success(false)
            }

        } catch  {
            return .failure(.readError(error.localizedDescription))
        }
    }
}
