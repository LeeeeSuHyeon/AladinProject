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
    private let isFavorite = BehaviorRelay(value: false)
    private let id : String
    private let itemAndFavorite = PublishRelay<(item : Product, isFavorite : Bool)>()
    
    init(id : String) {
        let detailCD = DetailCoreData()
        let detailManager = NetworkManager(session: DetailSession())
        let detailNetwork = DetailNetwork(manager: detailManager)
        let detailRP = DetailRepository(coreData: detailCD, network: detailNetwork)
        let detailUC = DetailUsecase(repository: detailRP)
        detailViewModel = DetailViewModel(usecase: detailUC)
        detailView = DetailView()

        self.id = id
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
//        Observable.combineLatest(self.item, self.isFavorite).bind {[weak self] item, isFavorite in
//            self?.detailView.config(item: item, isFavorite : isFavorite)
//        }.disposed(by: disposeBag)
        
        
        itemAndFavorite.bind {[weak self] item, isFavorite in
            self?.detailView.config(item: item, isFavorite: isFavorite)
        }.disposed(by: disposeBag)
        
        detailView.btnSaved.rx.tap.bind { [weak self] in
            guard let self = self else {return }
            let isFavorite = self.isFavorite.value
            self.isFavorite.accept(!isFavorite)
            // isFavorite 값에 따라 item을 변경 시켜줘야 함
            print("isFavorite : \(isFavorite)")
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let id =  BehaviorRelay(value: self.id)
        let input = DetailViewModel.Input(itemId: id.asObservable(), itemAndFavorite: itemAndFavorite.asObservable())
        let output = detailViewModel.transform(input: input)
//        let output = detailViewModel.transform(input: DetailViewModel.Input(saveItem: item.asObservable(), deleteItem: item.asObservable(), itemId: id.asObservable()))
        output.itemAndFavorite.bind {[weak self] product, isFavorite in
//            self?.item.accept(product)
            self?.itemAndFavorite.accept((product, isFavorite))
        }.disposed(by: disposeBag)
        
        output.error.bind { error in
            // alert 추가
            print(error)
        }.disposed(by: disposeBag)
        
//        output.isFavorite.bind { [weak self] isFavorite in
//            self?.isFavorite.accept(isFavorite)
//        }.disposed(by: disposeBag)
    }
}
