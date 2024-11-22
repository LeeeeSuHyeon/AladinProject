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
    func deleteSearchRecord(title : String) -> Result<Bool, CoreDataError>
    func deleteAllSearchRecord() -> Result<Bool, CoreDataError>
}

public class SearchCoreData : SearchCoreDataProtocol {
    
    let viewContext : NSManagedObjectContext?
    
    init() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.viewContext = appDelegate?.persistentContainer.viewContext
    }
    
    public func fetchSearchRecord() -> Result<[String], CoreDataError> {
        let fetchRequest : NSFetchRequest<SearchRecord> = SearchRecord.fetchRequest()
        guard let viewContext = viewContext else {
            return .failure(.readError("viewContext 없음"))
        }
        do {
            let results = try viewContext.fetch(fetchRequest)
            return .success(results.compactMap({ $0.title }))
        } catch {
            return .failure(.readError(error.localizedDescription))
        }
    }
    
    public func saveSearchRecord(title : String) -> Result<Bool, CoreDataError> {
        let isSavedTitle = self.isSavedTitle(title: title)
        switch isSavedTitle {
        case .success(let isSaved):
            guard isSaved else { return .success(false)}
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
            
        case .failure(let error):
            return .failure(error)
        }

    }
    
    private func isSavedTitle(title : String) -> Result<Bool, CoreDataError> {
        guard let viewContext = viewContext else {return .failure(.saveError("viewContext 없음"))}
        let fetchRequest = SearchRecord.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            return result.count > 0 ? .success(false) :  .success(true)

        } catch {
            return .failure(.readError(error.localizedDescription))
        }
    }
    
    public func deleteSearchRecord(title: String) -> Result<Bool, CoreDataError> {
        let fetchRequest = SearchRecord.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do {
            let result = try viewContext?.fetch(fetchRequest)
            result?.forEach({ title in
                viewContext?.delete(title)
            })
            
            try viewContext?.save()
            return .success(true)
        } catch  {
            return .failure(.deleteError(error.localizedDescription))
        }
    }
    
    public func deleteAllSearchRecord() -> Result<Bool, CoreDataError> {
        let fetchRequest = SearchRecord.fetchRequest()
        do {
            let result = try viewContext?.fetch(fetchRequest)
            result?.forEach({ title in
                viewContext?.delete(title)
            })
            
            try viewContext?.save()
            return .success(true)
        } catch  {
            return .failure(.deleteError(error.localizedDescription))
        }
    }
    
    
}
