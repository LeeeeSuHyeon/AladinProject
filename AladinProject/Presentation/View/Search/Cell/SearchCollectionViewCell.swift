//
//  SearchTableViewCell.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import UIKit
import RxSwift

class SearchCollectionViewCell : UICollectionViewCell {
    static let id = "SearchTableViewCell"
    public var disposeBag = DisposeBag()
    
    private let imgView = UIImageView().then { view in
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
    }
    
    private let grpTitle = ProductInfoStackView(title: "제목", viewAxis: .horizontal)
    
    private let grpAuthor = ProductInfoStackView(title: "저자", viewAxis: .horizontal)
    
    private let grpPrice = ProductInfoStackView(title: "정가", viewAxis: .horizontal)
    
    private let grpInfo = UIStackView().then { view in
        view.axis = .vertical
        view.distribution = .fillEqually
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            grpTitle,
            grpAuthor,
            grpPrice
        ].forEach{grpInfo.addArrangedSubview($0)}
        
        [
            imgView,
            grpInfo,
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        imgView.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(140)
            make.top.leading.bottom.equalToSuperview().inset(10)
        }
        
        grpInfo.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(imgView.snp.trailing).offset(10)
        }
    }
    
    public func config(item : Product){
        self.grpTitle.config(value: item.title)
        self.grpAuthor.config(value: item.author)
        self.grpPrice.config(value: item.priceStandard.getWonString())
        self.imgView.kf.setImage(with: URL(string: item.coverURL))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
}
