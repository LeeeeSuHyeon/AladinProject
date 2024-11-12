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
        text.backgroundColor = .systemGray5
        text.layer.cornerRadius = 10
        text.tintColor = .black
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUI()
    }
    
    private func setUI(){
        addSubview(textSearch)
        addSubview(collectionView)
        
        textSearch.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textSearch.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
