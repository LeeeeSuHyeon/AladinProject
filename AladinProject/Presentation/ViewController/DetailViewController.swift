//
//  DetailViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import UIKit
import RxSwift
import RxRelay

class DetailViewController: UIViewController {

    private let detailView : DetailView
    private let detailViewModel : DetailViewModelProtocol
    private let item = PublishRelay<Product>()
    private let disposeBag = DisposeBag()
    
    init(id : String) {
        let detailCD = DetailCoreData()
        let detailManager = NetworkManager(session: DetailSession())
        let detailNetwork = DetailNetwork(manager: detailManager)
        let detailRP = DetailRepository(coreData: detailCD, network: detailNetwork)
        let detailUC = DetailUsecase(repository: detailRP)
        detailViewModel = DetailViewModel(usecase: detailUC, id : id)
        detailView = DetailView()

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
    }
    
    private func bindView() {
        self.item.bind {[weak self] item in
            self?.detailView.config(item : item)
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let output = detailViewModel.transform(input: DetailViewModel.Input())
        
        output.item.bind {[weak self] product in
            self?.item.accept(product)
        }.disposed(by: disposeBag)
        
        output.error.bind { error in
            print(error)
        }.disposed(by: disposeBag)
    }
}
