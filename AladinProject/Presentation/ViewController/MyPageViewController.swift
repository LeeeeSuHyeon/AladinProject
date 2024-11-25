//
//  MyPageViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import RxSwift
import RxCocoa
import UIKit

class MyPageViewController: UIViewController {
    
    private let myPageView : MyPageView
    private let viewModel : MyPageViewModelProtocol
    private let disposeBag = DisposeBag()
    
    init() {
        let myPageRP = MyPageRepository()
        let myPageUC = MyPageUsecase(repository: myPageRP)
        self.viewModel = MyPageViewModel(usecase: myPageUC)
        self.myPageView = MyPageView()
        
        super.init(nibName: nil, bundle: nil)
        self.view = myPageView
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: MyPageViewModel.Input(loadInfo: Observable.just(())))
        
        output.userInfo.bind {[weak self] userInfo in
            self?.myPageView.config(profileImage: userInfo.profileImage, nickname: userInfo.nickname, account: userInfo.account)
        }.disposed(by: disposeBag)
        
        output.error.bind { error in
            print(error)
        }.disposed(by: disposeBag)
    }
}
