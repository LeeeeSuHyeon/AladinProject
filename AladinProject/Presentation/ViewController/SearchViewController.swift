//
//  SearchViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import UIKit

class SearchViewController: UIViewController {

    private let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = searchView
    }
}
