//
//  MyPageViewModel.swift
//  AladinProject
//
//  Created by 이수현 on 11/25/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol MyPageViewModelProtocol {
    func transform(input : MyPageViewModel.Input) -> MyPageViewModel.Output
}

public class MyPageViewModel : MyPageViewModelProtocol {
    private let usecase : MyPageUsecaseProtocol
    private let userInfo = PublishRelay<UserInfo>()
    private let error = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    init(usecase: MyPageUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
        let loadInfo : Observable<Void>
    }
    
    public struct Output {
        let userInfo : Observable<UserInfo>
        let error : Observable<String>
    }
    
    public func transform(input : Input) -> Output {
        input.loadInfo.bind {[weak self] in
            self?.fetchUserInfo()
        }.disposed(by: disposeBag)
        
        return Output(userInfo: userInfo.asObservable(), error: error.asObservable())
    }
    
    private func fetchUserInfo(){
        usecase.fetchUserInfo {[weak self] result in
            switch result {
            case .success(let userInfo):
                self?.userInfo.accept(userInfo)
            case .failure(let error):
                self?.error.accept(error.description)
            }
        }
    }
}
