//
//  HomeView.swift
//  AladinProject
//
//  Created by 이수현 on 11/12/24.
//

import UIKit
import Then
import SnapKit


class HomeView : UIView {
    let textSearch = UITextField().then { text in
        text.placeholder = "원하시는 책을 검색해주세요."
        text.font = .systemFont(ofSize: 14)
        let imgView = UIImageView(image: .init(systemName: "magnifyingglass"))
        imgView.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        text.leftView = imgView
        text.leftViewMode = .always
        text.backgroundColor = .systemGray
        text.layer.cornerRadius = 10
    }
    
    let collectionView = UICollectionView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
