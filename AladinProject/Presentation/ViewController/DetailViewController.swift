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
    private let saveItem = PublishRelay<Product>()
    private let deleteItem = PublishRelay<Product>()
    private let disposeBag = DisposeBag()
    private let id : String
    
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

    }
    
    private func bindViewModel() {
        let input = DetailViewModel.Input(
            saveItem: saveItem.asObservable(),
            deleteItem: deleteItem.asObservable(),
            itemId: Observable.just(id)
        )
        
        let output = detailViewModel.transform(input: input)
        
        output.detailData.bind{[weak self] detailData in
            guard let self = self else { return }
            
            self.detailView.config(item: detailData.item, isFavorite: detailData.isFavorite)
            
            self.detailView.btnSaved.rx.tap.bind {
                if detailData.isFavorite {
                    self.deleteItem.accept(detailData.item)
                } else {
                    self.saveItem.accept(detailData.item)
                }
            }.disposed(by: disposeBag)
            
//            self.detailView.btnSaved.isSelected.toggle()
            
        }.disposed(by: disposeBag)

        
        output.error.bind { error in
            // alert 추가
            print(error)
        }.disposed(by: disposeBag)
        
    }
}
