//
//  FavoriteViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import UIKit

class FavoriteViewController: UIViewController {

    let favoriteView = FavoriteView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = favoriteView
        
        navigationItem.title = "찜"
        setProtocol()
    }
    
    private func setProtocol(){
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
    }
}


extension FavoriteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension FavoriteViewController : UITableViewDelegate {
}
