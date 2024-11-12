//
//  HomeNewBookCollectionViewCell.swift
//  AladinProject
//
//  Created by 이수현 on 11/12/24.
//

import UIKit
import Kingfisher

class HomeNewBookCollectionViewCell: UICollectionViewCell {
    static let id = "HomeNewBookCollectionViewCell"
    
    let imgView = UIImageView().then { view in
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
    }
    
    let lblTitle = UILabel().then { lbl in
        lbl.backgroundColor = .white
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.numberOfLines = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUI()
    }
    
    private func setUI() {
        addSubview(imgView)
        addSubview(lblTitle)
        
        imgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        lblTitle.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.leading).inset(15)
            make.trailing.equalTo(imgView.snp.trailing).inset(15)
            make.bottom.equalTo(imgView.snp.bottom).inset(15)
        }
    }
    
    public func config(imageURL : String, title : String) {
        imgView.kf.setImage(with: URL(string: imageURL))
        lblTitle.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
