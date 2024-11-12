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
        view.contentMode = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUI()
    }
    
    private func setUI() {
        addSubview(imgView)
        
        imgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func config(imageURL : String) {
        imgView.kf.setImage(with: URL(string: imageURL))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
