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
    let searchRecord = BehaviorRelay<[String]>(value: [])
    let error = PublishRelay<String>()
    var page = 1
    
    init(usecase: SearchUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
        let loadRecord : Observable<Void>
        let query : Observable<String>
        let fetchMore : Observable<Void>
        let deleteTitle : Observable<String>
        let deleteAll : Observable<Void>
    }
    
    public struct Output {
        let itemList : Observable<[Product]>
        let searchRecord : Observable<[String]>
        let error : Observable<String>
    }
    
    public func transform(input : Input) -> Output {
        
        input.loadRecord.bind { [weak self] in
            self?.fetchSearchRecord()
        }.disposed(by: disposeBag)
        
        input.query.filter({ query in
            query != ""
        }).bind {[weak self] query in
            guard let self = self else {return}
            self.page = 1
            self.searchBook(query: query, page:page)
            self.saveSearchRecord(query : query)
        }.disposed(by: disposeBag)
        
        input.fetchMore
            .withLatestFrom(input.query)
            .bind { [weak self] query in
                guard let self = self, page < 10 else {return}
                self.searchBook(query: query, page: page)
        }.disposed(by: disposeBag)
        
        input.deleteTitle.bind {[weak self] title in
            self?.deleteSearchRecord(title : title)
        }.disposed(by: disposeBag)
        
        input.deleteAll.bind {[weak self] _ in
            self?.deleteAllSearchRecord()
        }.disposed(by: disposeBag)
        
        
        return Output(itemList: itemList.asObservable(), searchRecord: searchRecord.asObservable(), error: error.asObservable())
    }
    
    private func fetchSearchRecord(){
        let result = usecase.fetchSearchRecord()
        switch result {
        case .success(let searchList):
            print("searchList \(searchList)")
            self.searchRecord.accept(searchList)
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
    
    private func searchBook(query : String, page : Int){
        Task {
            let result = await usecase.searchBook(query: query, page: page)
            switch result {
            case .success(let productResult):
                if page == 1 {
                    itemList.accept(productResult.item)
                } else {
                    if productResult.totalResults >= itemList.value.count {
//                        var items = Set(itemList.value)
                        let results = productResult.item.filter { item in
                            !itemList.value.contains(item)
                        }
                        itemList.accept(itemList.value + results)
                    }
                }
                self.page += 1
                
            case .failure(let error):
                self.error.accept(error.description)
            }
        }
    }
    
    private func saveSearchRecord(query : String) {
        let result = usecase.saveSearchRecord(title: query)
        switch result {
        case .success(let isSaved):
            print(isSaved ? "saveSearchRecord : \(query)" : "이미 있음")
            self.fetchSearchRecord()
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
    
    private func deleteAllSearchRecord() {
        let result = usecase.deleteAllSearchRecord()
        switch result {
        case .success(let success):
            if success {
                print("deleteAllSearchRecord - Success")
                fetchSearchRecord()
            } else {
                print("deleteAllSearchRecord - fail")
            }
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
    
    private func deleteSearchRecord(title : String) {
        let result = usecase.deleteSearchRecord(title: title)
        
        switch result {
        case .success(_):
            self.fetchSearchRecord()
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
    
}
