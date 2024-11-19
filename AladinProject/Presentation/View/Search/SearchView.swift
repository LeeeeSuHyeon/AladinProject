//
//  SearchView.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import UIKit

class SearchView: UIView {
    
    private let grpTopView = UIView()
    public let txtSearch = SearchTextField()
    public let btnDismiss = UIButton().then { btn in
        btn.setTitle("취소", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    public let tableView = UITableView().then { view in
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
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
            txtSearch,
            btnDismiss
        ].forEach{ grpTopView.addSubview($0) }
            
        [
            grpTopView,
            tableView
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        grpTopView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        txtSearch.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(btnDismiss.snp.leading)
        }
        
        btnDismiss.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(txtSearch.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }    
}
