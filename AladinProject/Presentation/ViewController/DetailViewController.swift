//
//  DetailViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import UIKit

class DetailViewController: UIViewController {

    private let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
    }
}
