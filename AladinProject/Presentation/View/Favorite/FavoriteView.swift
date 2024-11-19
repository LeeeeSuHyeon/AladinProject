//
//  FavoriteView.swift
//  AladinProject
//
//  Created by 이수현 on 11/19/24.
//

import UIKit

class FavoriteView : UIView {
    
    private let lblTitle = UILabel().then { lbl in
        lbl.text = "찜"
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.textAlignment = .center
    }
    
    let tableView = UITableView().then { view in
        view.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.id)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubView(){
        [
            tableView,
            lblTitle
        ].forEach{self.addSubview($0)}
        
    }
    
    private func setUI(){
        
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
