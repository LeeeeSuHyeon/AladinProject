//
//  SearchViewModel.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol SearchViewModelProtocol {
    func transform(input : SearchViewModel.Input) -> SearchViewModel.Output
}

public class SearchViewModel : SearchViewModelProtocol {
    let usecase : SearchUsecaseProtocol
    let disposeBag = DisposeBag()
    let itemList = BehaviorRelay<[Product]>(value: [])
    let error = PublishRelay<String>()
    var page = 1
    
    init(usecase: SearchUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
        let query : Observable<String>
        let fetchMore : Observable<Void>
    }
    
    public struct Output {
        let itemList : Observable<[Product]>
        let error : Observable<String>
    }
    
    public func transform(input : Input) -> Output {
        input.query.bind {[weak self] query in
            guard let self = self else {return}
            self.page = 1
            self.searchBook(query: query, page:page)
        }.disposed(by: disposeBag)
        
        input.fetchMore
            .withLatestFrom(input.query)
            .bind { [weak self] query in
                guard let self = self, page < 10 else {return}
                page += 1
                self.searchBook(query: query, page: page)
        }.disposed(by: disposeBag)
        
        
        return Output(itemList: itemList.asObservable(), error: error.asObservable())
    }
    
    private func searchBook(query : String, page : Int){
        Task {
            let result = await usecase.searchBook(query: query, page: page)
            switch result {
            case .success(let productResult):
                if page == 1 {
                    itemList.accept(productResult.item)
                } else {
                    itemList.accept(itemList.value + productResult.item)
                }
                
            case .failure(let error):
                self.error.accept(error.description)
            }
        }
    }
    
}
