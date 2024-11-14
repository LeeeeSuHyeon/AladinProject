//
//  Product.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import Foundation

public struct ProductResult : Decodable {
    let item : [Product]
    
    enum CodingKeys: CodingKey {
        case item
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.item = try container.decode([Product].self, forKey: .item)
    }
}


public struct Product : Decodable, Hashable {
    let id : String
    let title : String
    let author : String
    let publisher : String
    let priceSales : Int
    let priceStandard : Int
    let coverURL : String
    let linkURL : String
    let type : String
    let description : String
    let publishDate : String
    
    enum CodingKeys: String, CodingKey {
        case id = "isbn"
        case title
        case linkURL = "link"
        case author
        case publishDate = "pubDate"
        case description
        case priceSales
        case priceStandard
        case type = "mallType"
        case coverURL = "cover"
        case publisher
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.linkURL = try container.decode(String.self, forKey: .linkURL)
        self.author = try container.decode(String.self, forKey: .author)
        self.publishDate = try container.decode(String.self, forKey: .publishDate)
        self.description = try container.decode(String.self, forKey: .description)
        self.priceSales = try container.decode(Int.self, forKey: .priceSales)
        self.priceStandard = try container.decode(Int.self, forKey: .priceStandard)
        self.type = try container.decode(String.self, forKey: .type)
        self.coverURL = try container.decode(String.self, forKey: .coverURL)
        self.publisher = try container.decode(String.self, forKey: .publisher)
    }
}
