//
//  HomeRespositoryProtocol.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import Foundation

public protocol HomeRepositoryProtocol {
    func searchBook(query : String) async -> Result<BookResult, NetworkError>
    func fetchBookList(query : queryType) async -> Result<BookResult, NetworkError>
    func searchRecord() -> Result<[String], CoreDataError>
}
