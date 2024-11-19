//
//  FavoriteView.swift
//  AladinProject
//
//  Created by 이수현 on 11/19/24.
//

import UIKit

class FavoriteView : UIView {
    
    let tableView = UITableView().then { view in
        view.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.id)
        view.separatorStyle = .none
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(tableView)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
