//
//  Book.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import Foundation

public struct Category : Hashable {
    let imageURL : String
    let title : String
    
    static func dummy() -> [Category] {
        return [
            Category(imageURL: "https://cdn.imweb.me/thumbnail/20230411/7d1fdc5c533fd.jpg",
                     title: "도서"),
            Category(imageURL: "https://image.yes24.com/usedshop/2019/0823/_/dbd88e2f-c4a1-4f4f-bdd4-e78159357c76_XL.jpg",
                     title: "외국도서"),
            Category(imageURL: "https://dimg.donga.com/wps/NEWS/IMAGE/2017/06/22/85019718.3.jpg",
                     title: "음반"),
            Category(imageURL: "https://harrison-cameras.s3.amazonaws.com/p/l/DVD-TO-DVD/DVD-TO-DVD.jpg",
                     title: "DVD"),
            Category(imageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7xaa-yIa4aM8jl2QTKCFb3--wAxD9TxVkBg&s",
                     title: "중고샵"),
            Category(imageURL: "https://static1.makeuseofimages.com/wordpress/wp-content/uploads/2024/06/kindle-ebook-reader-on-open-books-background.jpg?q=70&fit=crop&w=1100&h=618&dpr=1",
                     title: "전자책"),
            Category(imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Republic_Of_Korea_Broadcasting-TV_Rating_System%28ALL%29.svg/500px-Republic_Of_Korea_Broadcasting-TV_Rating_System%28ALL%29.svg.png",
                     title: "All"),
        ]
    }
}

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


public struct Book : Decodable, Hashable {
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
