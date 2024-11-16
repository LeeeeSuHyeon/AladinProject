//
//  SearchView.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import UIKit

class SearchView: UIView {
    
    public let txtSearch = SearchTextField()
    
    public let tableView = UITableView().then { view in
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
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
            txtSearch,
            tableView
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        txtSearch.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(txtSearch.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }    
}
