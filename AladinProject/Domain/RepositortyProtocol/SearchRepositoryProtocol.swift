//
//  SearchRepositoryProtocol.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import Foundation


public protocol SearchRepositoryProtocol {
    func searchBook(query : String, page : Int) async -> Result<ProductResult, NetworkError>
    func fetchSearchRecord() -> Result<[String], CoreDataError>
    func saveSearchRecord(title : String) -> Result<Bool, CoreDataError>
    func deleteSearchRecord(title : String) -> Result<Bool, CoreDataError>
    func deleteAllSearchRecord() -> Result<Bool, CoreDataError>
}
