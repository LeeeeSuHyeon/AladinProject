//
//  HomeFooterView.swift
//  AladinProject
//
//  Created by 이수현 on 11/23/24.
//

import UIKit

class HomeFooterView: UICollectionReusableView {
    static let id = "HomeFooterView"
    
    private let underlineView = UIView().then { view in
        view.backgroundColor = .systemGray4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        self.addSubview(underlineView)
        
        underlineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview()
        }

    }
}

