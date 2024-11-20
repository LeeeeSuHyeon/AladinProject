//
//  DetailView.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import UIKit
import Kingfisher

class DetailView : UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imgView = UIImageView().then { view in
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
    }
    
    private let grpHorizontalInfo = UIStackView().then { view in
        view.axis = .vertical
        view.spacing = 8
    }
    
    private let grpTitle = ProductInfoStackView(title: "제목", viewAxis: .horizontal)
    private let grpAuthor = ProductInfoStackView(title: "저자", viewAxis: .horizontal)
    private let grpPriceStandard = ProductInfoStackView(title: "정가", viewAxis: .horizontal)
    private let grpPriceSales = ProductInfoStackView(title: "판매가", viewAxis: .horizontal)
    
    private let grpButton = UIStackView().then { grp in
        grp.axis = .horizontal
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
    
    public lazy var btnSaved = UIButton().then { btn in
        btn.setImage(.init(systemName: "heart"), for: .normal)
        btn.setImage(.init(systemName: "heart.fill"), for: .selected)
        btn.tintColor = .red
    }
    
    private let grpVerticalInfo = UIStackView().then { view in
        view.axis = .vertical
        view.spacing = 30
    }
    
    private let grpTitleDetail = ProductInfoStackView(title: "제목", viewAxis: .vertical)
    private let grpAuthorDetail = ProductInfoStackView(title: "저자", viewAxis: .vertical)
    
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
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)

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
            grpTitleDetail,
            grpAuthorDetail,
            grpPublishDate,
            grpProductLink,
            grpDescription
        ].forEach{ grpVerticalInfo.addArrangedSubview($0)}
        
        [
            imgView,
            grpHorizontalInfo,
            grpVerticalInfo
        ].forEach{contentView.addSubview($0)}
    
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
            make.trailing.equalToSuperview().inset(10)
        }
        
        grpVerticalInfo.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(15)
            make.leading.equalTo(imgView.snp.leading)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    public func config(item : Product, isFavorite : Bool) {
        self.imgView.kf.setImage(with: URL(string: item.coverURL))
        self.grpTitle.config(value: item.title)
        self.grpTitleDetail.config(value: item.title)
        self.grpAuthor.config(value: item.author)
        self.grpAuthorDetail.config(value: item.author)
        self.grpDescription.config(value: item.description)
        self.grpPriceSales.config(value: item.priceSales.getWonString())
        self.grpPriceStandard.config(value: item.priceStandard.getWonString())
        self.grpProductLink.config(value: item.linkURL)
        self.grpPublishDate.config(value: item.publishDate)
        
        self.btnSaved.isSelected = isFavorite
    }
}
