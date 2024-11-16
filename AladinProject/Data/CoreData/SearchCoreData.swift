//
//  SearchCoreData.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import UIKit
import CoreData

public protocol SearchCoreDataProtocol {
    func fetchSearchRecord() -> Result<[String], CoreDataError>
    func saveSearchRecord(title : String) -> Result<Bool, CoreDataError>
}

public class SeachCoreData : SearchCoreDataProtocol {
    
    let viewContext : NSManagedObjectContext?
    
    init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.viewContext = appDelegate?.persistentContainer.viewContext
    }
    
    public func fetchSearchRecord() -> Result<[String], CoreDataError> {
        let fetchRequest : NSFetchRequest<SearchRecord> = SearchRecord.fetchRequest()
        
        do {
            let results = try viewContext?.fetch(fetchRequest) ?? []
            return .success(results.compactMap({ $0.title }))
        } catch {
            return .failure(.readError(error.localizedDescription))
        }
    }
    
    public func saveSearchRecord(title : String) -> Result<Bool, CoreDataError> {
        guard let viewContext = viewContext, let entity = NSEntityDescription.entity(forEntityName: "SearchRecord", in: viewContext) else {
            return . failure(.entityNotFound("SearchRecord 없음"))
        }
        let object = NSManagedObject(entity: entity, insertInto: viewContext)
        
        object.setValue(title, forKey: "title")
        
        do {
            try viewContext.save()
            return .success(true)
        } catch {
            return .failure(.saveError(error.localizedDescription))
        }
    }
    
}
