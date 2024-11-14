//
//  DetailViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import UIKit

class DetailViewController: UIViewController {

    private let detailView : DetailView
    private let detailViewModel : DetailViewModelProtocol
    private let network : DetailNetworkProtocol
    
    init(id : String) {
        let detailCD = DetailCoreData()
        let detailManager = NetworkManager(session: DetailSession())
        let detailNetwork = DetailNetwork(manager: detailManager)
        let detailRP = DetailRepository(coreData: detailCD, network: detailNetwork)
        let detailUC = DetailUsecase(repository: detailRP)
        detailViewModel = DetailViewModel(usecase: detailUC, id : id)
        detailView = DetailView()
        network = detailNetwork

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        
        bindView()
        bindViewModel()
        Task {
            await test()
        }
    }
    
    private func bindView() {
        
    }
    
    private func bindViewModel() {
        
    }
    
    private func test() async {
        let result = await network.fetchItem(id: "9791163166139")
        
        switch result {
        case .success(let item):
            print(item)
        case .failure(let error):
            print(error.description)
        }
    }
}
