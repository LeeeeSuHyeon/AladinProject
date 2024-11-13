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
    private let underlineView = UIView().then { view in
        view.backgroundColor = .systemGray4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI(){
        addSubview(lblHeader)
        addSubview(underlineView)
        
        lblHeader.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(underlineView.snp.bottom).offset(20)
        }
        
        underlineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview()
        }
    }
    
    public func config(header : String) {
        lblHeader.text = header
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
