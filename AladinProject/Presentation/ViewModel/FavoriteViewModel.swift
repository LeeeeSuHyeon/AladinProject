//
//  FavoriteViewModel.swift
//  AladinProject
//
//  Created by 이수현 on 11/19/24.
//

import Foundation
import RxSwift
import RxCocoa

public protocol FavoriteViewModelProtocol {
    func transform(input : FavoriteViewModel.Input) -> FavoriteViewModel.Output
}

public class FavoriteViewModel : FavoriteViewModelProtocol {
    
    private let usecase : FavoriteUsecaseProtocol
    private let error = PublishRelay<String>()
    private let itemList = BehaviorRelay<[FavoriteItem]>(value: [])
    private let disposeBag = DisposeBag()
    
    init(usecase: FavoriteUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
        let deleteItem : Observable<String>
        let viewDidLoad : Observable<Void>
    }
    
    public struct Output {
        let itemList : Observable<[FavoriteItem]>
        let error : Observable<String>
    }
    
    public func transform(input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] in
            self?.fetchItem()
        }.disposed(by: disposeBag)
        
        input.deleteItem.bind {[weak self] id in
            self?.deleteItem(id : id)
        }.disposed(by: disposeBag)
        
        let itemList = self.itemList.asObservable()
        
        return Output(itemList: itemList, error: error.asObservable())
    }
    
    private func fetchItem() {
        let result = usecase.fetchFavoriteItem()
        
        switch result {
        case .success(let itemList):
            self.itemList.accept(itemList)
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
    
    
    private func deleteItem(id : String) {
        print("deleteItem : \(id)")
        let result =  usecase.deleteFavoriteItem(id: id)
        
        switch result {
        case .success(let success):
            fetchItem()
            print(success)
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
}
