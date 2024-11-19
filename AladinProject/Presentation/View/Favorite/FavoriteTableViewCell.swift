//
//  FavoriteTableViewCell.swift
//  AladinProject
//
//  Created by 이수현 on 11/19/24.
//

import UIKit
import RxSwift

class FavoriteTableViewCell: UITableViewCell {
    static let id = "FavoriteTableViewCell"
    
    public var disposeBag = DisposeBag()
    
    private let imgView = UIImageView().then { view in
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
    }
    
    private let grpTitle = ProductInfoStackView(title: "제목", viewAxis: .horizontal)
    
    private let grpAuthor = ProductInfoStackView(title: "저자", viewAxis: .horizontal)
    
    private let grpInfo = UIStackView().then { view in
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 10
    }
    
    public let btnSaved = UIButton().then { btn in
        var config = UIButton.Configuration.plain()
        
        config.image = .init(systemName: "heart.fill")
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        btn.configuration = config
        btn.tintColor = .red
        btn.clipsToBounds = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            imgView,
            grpInfo,
            btnSaved
        ].forEach{self.addSubview($0)}
        
        [
            grpTitle,
            grpAuthor
        ].forEach{grpInfo.addArrangedSubview($0)}
    }
    
    private func setUI(){
        imgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(60)
            make.height.equalTo(90).priority(.high)
        }
        
        grpInfo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imgView.snp.trailing).offset(10)
            make.trailing.equalTo(btnSaved.snp.leading)
        }
        
        btnSaved.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag() // 재사용 시 새로운 DisposeBag 생성
    }
    
    public func config(item : FavoriteItem) {
        imgView.kf.setImage(with: URL(string: item.imageURL ?? ""))
        grpTitle.config(value: item.title ?? "")
        grpAuthor.config(value: item.author ?? "")
        btnSaved.isSelected = true
    }
}
