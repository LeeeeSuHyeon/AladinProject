//
//  HomeCategoryCollectionViewCell.swift
//  AladinProject
//
//  Created by 이수현 on 11/12/24.
//

import UIKit

class HomeCategoryCollectionViewCell: UICollectionViewCell {
    static let id = "HomeCategoryCollectionViewCell"
    
    let imgView = UIImageView().then { view in
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
    }
    
    let lblTitle = UILabel().then { lbl in
        lbl.font = .systemFont(ofSize: 10, weight: .bold)
        lbl.numberOfLines = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUI()
    }
    
    private func setUI(){
        addSubview(imgView)
        addSubview(lblTitle)
        
        imgView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    public func config(imgURL : String, title : String) {
        imgView.kf.setImage(with: URL(string: imgURL))
        lblTitle.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
