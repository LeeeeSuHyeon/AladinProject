//
//  DetailView.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import UIKit

class DetailView : UIView {
    private let imgView = UIImageView().then { view in
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
    }
    
    private let grpHorizontalInfo = UIStackView().then { view in
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fill
    }
    
    private let grpTitle = ProductInfoStackView(title: "제목", viewAxis: .horizontal)
    private let grpAuthor = ProductInfoStackView(title: "저자", viewAxis: .horizontal)
    private let grpPriceStandard = ProductInfoStackView(title: "정가", viewAxis: .horizontal)
    private let grpPriceSales = ProductInfoStackView(title: "판매가", viewAxis: .horizontal)
    
    private let grpButton = UIStackView().then { grp in
        grp.axis = .horizontal
        grp.distribution = .fill
        grp.spacing = 8
    }
    
    public let btnPurchase = UIButton().then { btn in
        btn.setTitle("구매하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(.black, for: .selected)
        btn.backgroundColor = .tintColor
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    public let btnSaved = UIButton().then { btn in
        btn.setImage(.init(systemName: "heart"), for: .normal)
        btn.setImage(.init(systemName: "heart.fill"), for: .selected)
        btn.tintColor = .red
    }
    
    private let grpVerticalInfo = UIStackView().then { view in
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fill
    }
    
    private let grpPublishDate = ProductInfoStackView(title: "출간일", viewAxis: .vertical)
    private let grpProductLink = ProductInfoStackView(title: "상품 링크", viewAxis: .vertical)
    private let grpDescription = ProductInfoStackView(title: "상품 설명", viewAxis: .vertical)
    
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
            grpTitle,
            grpAuthor,
            grpPriceStandard,
            grpPriceSales,
            grpButton
        ].forEach { grpHorizontalInfo.addArrangedSubview($0) }
        
        [
            btnPurchase,
            btnSaved
        ].forEach{grpButton.addArrangedSubview($0)}
        
        [
            grpPublishDate,
            grpProductLink,
            grpDescription
        ].forEach{ grpVerticalInfo.addArrangedSubview($0)}
        
        [
            imgView,
            grpHorizontalInfo,
            grpVerticalInfo
        ].forEach{self.addSubview($0)}
    
    }
    
    private func setUI(){
        imgView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        
        grpHorizontalInfo.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.top).offset(5)
            make.leading.equalTo(imgView.snp.trailing).offset(10)
            make.bottom.equalTo(imgView.snp.bottom)
        }
        
        grpVerticalInfo.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(15)
            make.leading.equalTo(imgView.snp.leading)
            make.bottom.equalToSuperview()
        }
    }
}
