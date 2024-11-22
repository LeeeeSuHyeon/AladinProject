//
//  SearchRecordCell.swift
//  AladinProject
//
//  Created by 이수현 on 11/21/24.
//

import UIKit

class SearchRecordCell : UICollectionViewCell {
    static let id = "SeachRecordCell"
    
    private let grpView = UIView().then { view in
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
    }
    private let lblTitle = UILabel().then { lbl in
        lbl.font = .systemFont(ofSize: 10, weight: .bold)
        lbl.numberOfLines = 1
    }
    
    public let btnRemove = UIButton().then { btn in
        btn.setImage(.init(systemName: "xmark.circle"), for: .normal)
        btn.tintColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setSubview()
        setUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview(){
        [
            lblTitle,
            btnRemove
        ].forEach{grpView.addSubview($0)}
        
        self.addSubview(grpView)
    }
    
    private func setUI(){
        grpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lblTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(6)
            make.centerY.equalToSuperview()
        }
        
        btnRemove.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(6)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
    public func config(title : String) {
        lblTitle.text = title
    }
}
