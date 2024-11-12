//
//  HomeBestSellerCollectionViewCell.swift
//  AladinProject
//
//  Created by 이수현 on 11/12/24.
//

import UIKit

class HomeBestSellerCollectionViewCell: UICollectionViewCell {
    static let id = "HomeBestSellerCollectionViewCell"
    
    let imgView = UIImageView().then { view in
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
    }
    
    let lblTitle = UILabel().then { lbl in
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
        lbl.numberOfLines = 1
    }
    
    let lblAuthor = UILabel().then { lbl in
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
        lbl.numberOfLines = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI(){
        addSubview(imgView)
        addSubview(lblTitle)
        
        imgView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        lblAuthor.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    public func config(imgURL : String, title : String, author : String) {
        imgView.kf.setImage(with: URL(string: imgURL))
        lblTitle.text = title
        lblAuthor.text = author
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
