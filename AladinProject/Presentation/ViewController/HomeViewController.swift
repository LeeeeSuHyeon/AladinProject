//
//  ViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    let viewModel : HomeViewModelProtocol
    let disposeBag = DisposeBag()
    
    init() {
        let homeSession = HomeSession()
        let networkManager = NetworkManager(session: homeSession)
        let homeNetwork = HomeNetwork(manage: networkManager)
        let homeRP = HomeRespository(network: homeNetwork)
        let homeUC = HomeUsecase(repository: homeRP)
        self.viewModel = HomeViewModel(usecase: homeUC)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red

        
        bindViewModel()
    }
    
    private func bindViewModel(){
        let output = viewModel.transfrom(input: HomeViewModel.Input(viewDidLoad: Observable.just(Void())))
        output.bestSellerList.bind(onNext: { bookList in
            print(bookList)
        }).disposed(by: disposeBag)
        
        output.newBookList.bind { bookList in
            print(bookList)
        }.disposed(by: disposeBag)
    }

//    private func test(){
//
//        Task {
//            let result = await homeUC.fetchBestSellerList()
//            switch result {
//            case .success(let data):
//                print(data.item)
//            case .failure(let error):
//                print(error.description)
//            }
//        }
//    }

}

