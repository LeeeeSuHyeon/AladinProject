//
//  FavoriteTableViewCell.swift
//  AladinProject
//
//  Created by 이수현 on 11/19/24.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    static let id = "FavoriteTableViewCell"
    
    private let imgView = UIImageView().then { view in
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
    }
    
    private let grpTitle = ProductInfoStackView(title: "제목", viewAxis: .horizontal)
    
    private let grpAuthor = ProductInfoStackView(title: "저자", viewAxis: .horizontal)
    
    private let grpInfo = UIStackView().then { view in
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .leading
    }
    
    private let btnSaved = UIButton().then { btn in
        btn.setImage(.init(systemName: "heart"), for: .normal)
        btn.setImage(.init(systemName: "heart.fill"), for: .selected)
        btn.tintColor = .red
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubject()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubject(){
        [
            imgView,
            grpInfo,
            btnSaved
        ].forEach{self.addSubview($0)}
        
        [
            grpTitle,
            grpAuthor
        ].forEach{grpInfo.addSubview($0)}
    }
    
    private func setUI(){
        imgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        
        grpInfo.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(imgView.snp.trailing).offset(10)
        }
        
        btnSaved.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.leading.equalTo(grpInfo.snp.trailing)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
    }
}
