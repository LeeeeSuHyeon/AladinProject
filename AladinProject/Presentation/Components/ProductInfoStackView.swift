//
//  ProductInfoView.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import UIKit

class ProductInfoStackView : UIStackView {
    
    let title : String
    let viewAxis : NSLayoutConstraint.Axis
    
    private lazy var lblTitle = UILabel().then { lbl in
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.text = title
        lbl.textAlignment = viewAxis == .horizontal ? .center : .left
//        lbl.setContentHuggingPriority(.required, for: .horizontal)
//        lbl.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private lazy var lblValue = UILabel().then { lbl in
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textAlignment =  .left
        lbl.numberOfLines = viewAxis == .horizontal ? 1 : 0
    }
    
    init(title: String, viewAxis : NSLayoutConstraint.Axis) {
        self.title = title
        self.viewAxis = viewAxis
        super.init(frame: .zero)
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.axis = viewAxis
        self.spacing = 8
    
        
        addArrangedSubview(lblTitle)
        addArrangedSubview(lblValue)
        
        lblTitle.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.width.equalTo(50)
        }
    }
    
    public func config(value : String) {
        self.lblValue.text = value
    }
    
}
