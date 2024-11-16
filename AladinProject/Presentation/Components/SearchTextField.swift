//
//  SearchTextField.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import UIKit


class SearchTextField : UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.placeholder = "원하시는 책을 검색해주세요."
        self.font = .systemFont(ofSize: 14)
        let imgView = UIImageView(image: .init(systemName: "magnifyingglass"))
        imgView.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        self.leftView = imgView
        self.leftViewMode = .always
        self.backgroundColor = .systemGray5
        self.layer.cornerRadius = 10
        self.tintColor = .black

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
