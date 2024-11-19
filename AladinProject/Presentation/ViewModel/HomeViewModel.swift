//
//  HomeViewModel.swift
//  AladinProject
//
//  Created by 이수현 on 11/12/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol HomeViewModelProtocol {
     func transfrom(input : HomeViewModel.Input) -> HomeViewModel.Output
}


public class HomeViewModel : HomeViewModelProtocol{
    private let usecase : HomeUsecaseProtocol
    private let disposeBag = DisposeBag()
    
    private let error = PublishRelay<String>()
    private let bestSellerList = PublishRelay<[Product]>()
    private let newBookList = PublishRelay<[Product]>()
//    private var page = 0
    
    init(usecase: HomeUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
        let viewDidLoad : Observable<Void>
//        let fetchMore : Observable<Void>
    }
    
    public struct Output {
        let bestSellerList : Observable<[Product]>
        let newBookList : Observable<[Product]>
        let error : Observable<String>
    }
    
    public func transfrom(input : Input) -> Output {
        input.viewDidLoad.bind { [weak self] in
            self?.fetchBestSellerBook()
            self?.fetchNewBook()
        }.disposed(by: disposeBag)

        return Output(bestSellerList: self.bestSellerList.asObservable(), newBookList: self.newBookList.asObservable(), error: error.asObservable())
    }

    private func fetchBestSellerBook() {
        Task{
            let bestSellerResult = await usecase.fetchBestSellerList()
            switch bestSellerResult {
            case .success(let productResult):
                self.bestSellerList.accept(productResult.item)
            case .failure(let error):
                self.error.accept(error.description)
            }
        }
    }
    
    private func fetchNewBook(){
        Task{
            let newBookResult = await usecase.fetchNewBookList()
            switch newBookResult {
            case .success(let newBookResult):
                self.newBookList.accept(newBookResult.item)
            case .failure(let error):
                self.error.accept(error.description)
            }
        }
    }
}
