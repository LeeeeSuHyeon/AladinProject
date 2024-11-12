//
//  Book.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import Foundation

public struct BookResult : Decodable {
    let item : [Book]
    
    enum CodingKeys: CodingKey {
        case item
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.item = try container.decode([Book].self, forKey: .item)
    }
}


public struct Book : Decodable {
    let title : String
    let author : String
    let publisher : String
    let price : Int
    let coverURL : String
    let linkURL : String
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case publisher
        case price = "priceStandard"
        case coverURL = "cover"
        case linkURL = "link"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.author = try container.decode(String.self, forKey: .author)
        self.publisher = try container.decode(String.self, forKey: .publisher)
        self.price = try container.decode(Int.self, forKey: .price)
        self.coverURL = try container.decode(String.self, forKey: .coverURL)
        self.linkURL = try container.decode(String.self, forKey: .linkURL)
    }
}
