//
//  SearchRecordHeaderCell.swift
//  AladinProject
//
//  Created by 이수현 on 11/23/24.
//

import UIKit


class SearchRecordHeaderCell : UICollectionViewCell {
    static let id = "SearchRecordHeaderCell"
    
    private let lblTitle = UILabel().then { lbl in
        lbl.text = "검색 기록"
        lbl.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    public let btnAllDelete = UIButton().then { btn in

        var config = UIButton.Configuration.plain()
        config.title = "검색 기록 전체 삭제"
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 10)
        config.titleAlignment = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        btn.configuration = config
        btn.tintColor = .systemGray2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView() {
        [
            lblTitle,
            btnAllDelete
        ].forEach{self.contentView.addSubview($0)}
    }
    private func setUI(){
        lblTitle.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        btnAllDelete.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            make.width.equalTo(110)
            make.height.equalTo(15)
        }
    }
}
