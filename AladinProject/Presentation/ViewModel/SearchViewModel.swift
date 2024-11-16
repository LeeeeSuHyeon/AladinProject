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
    let itemList = PublishRelay<[Product]>()
    let error = PublishRelay<String>()
    
    init(usecase: SearchUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
        let query : Observable<String>
    }
    
    public struct Output {
        let itemList : Observable<[Product]>
        let error : Observable<String>
    }
    
    public func transform(input : Input) -> Output {
        input.query.bind {[weak self] query in
            self?.searchBook(query: query)
        }.disposed(by: disposeBag)
        
        
        return Output(itemList: itemList.asObservable(), error: error.asObservable())
    }
    
    private func searchBook(query : String){
        Task {
            let result = await usecase.searchBook(query: query)
            switch result {
            case .success(let productResult):
                itemList.accept(productResult.item)
            case .failure(let error):
                self.error.accept(error.description)
            }
        }
        
    }
    
}
