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
            self?.fetchBook()
        }.disposed(by: disposeBag)

        return Output(bestSellerList: self.bestSellerList.asObservable(), newBookList: self.newBookList.asObservable(), error: error.asObservable())
    }

    private func fetchBook() {
        Task{
            do {
                let bestSellerResult = try await usecase.fetchBestSellerList().get().item
                let newBookList = try await usecase.fetchNewBookList().get().item
                
                self.bestSellerList.accept(bestSellerResult)
                self.newBookList.accept(newBookList)
            } catch {
                print(error)
                self.error.accept(error.localizedDescription)
            }

        }

    }
}
