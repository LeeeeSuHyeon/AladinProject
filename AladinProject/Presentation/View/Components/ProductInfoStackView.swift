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
        lbl.textAlignment = .left
    }
    
    private lazy var lblValue = UILabel().then { lbl in
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textAlignment = .left
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
        self.distribution = .fillEqually
        addArrangedSubview(lblTitle)
        addArrangedSubview(lblValue)
    }
    
    public func setValue(value : String) {
        self.lblValue.text = value
    }
    
}
