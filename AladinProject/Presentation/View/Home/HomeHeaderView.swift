//
//  HomeHeaderView.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import UIKit

class HomeHeaderView: UICollectionReusableView {
    static let id = "HomeHeaderView"
    
    private let lblHeader = UILabel().then { lbl in
        lbl.font = .systemFont(ofSize: 25, weight: .bold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI(){
        addSubview(lblHeader)
        
        lblHeader.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }

    }
    
    public func config(header : String) {
        lblHeader.text = header
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
