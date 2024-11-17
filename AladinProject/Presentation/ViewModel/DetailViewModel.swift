//
//  DetailViewModel.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import UIKit
import RxSwift
import RxCocoa

public protocol DetailViewModelProtocol {
    func transform(input : DetailViewModel.Input) -> DetailViewModel.Output
}

public class DetailViewModel : DetailViewModelProtocol {
    private let usecase : DetailUsecaseProtocol
    private let error = PublishRelay<String>()
    private let item = PublishRelay<Product>()
    private let disposeBag = DisposeBag()
    private let isFavorite = PublishRelay<Bool>()
    private let itemAndFavorite = PublishRelay<(item : Product, isFavorite : Bool)>()
    
    
    init(usecase: DetailUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
//        let saveItem : Observable<Product>
//        let deleteItem : Observable<Product>
        let itemId : Observable<String>
        let itemAndFavorite : Observable<(item : Product, isFavorite : Bool)>
//        let clickLink : Observable<String>
//        let purchaseItem : Observable<Void>
    }
    
    public struct Output {
        let item : Observable<Product>
        let itemAndFavorite : Observable<(item : Product, isFavorite : Bool)>
        let error : Observable<String>
//        let isFavorite : Observable<Bool>
    }
    
    public func transform(input: Input) -> Output {
        
        input.itemId.bind {[weak self] id in
            self?.fetchItem(id: id)
            self?.checkFavoriteItem(id: id)
        }.disposed(by: disposeBag)
        
        input.itemAndFavorite.bind { [weak self] item, isFavorite in
            if isFavorite {
                self?.saveFavoriteItem(item: item)
            } else {
                self?.deleteFavoriteItem(item: item)
            }
        }.disposed(by: disposeBag)
        
//        input.saveItem.bind {[weak self] product in
//            self?.saveFavoriteItem(product: product)
//        }.disposed(by: disposeBag)
//        
//        input.deleteItem.bind { [weak self] Product in
//            self?.deleteFavoriteItem(id : Product.id)
//        }.disposed(by: disposeBag)
        

//        return Output(item: item.asObservable(), error: self.error.asObservable(), isFavorite: isFavorite.asObservable())
        
        return Output(item: item.asObservable(), itemAndFavorite: itemAndFavorite.asObservable(), error: error.asObservable())
    }
    
    private func fetchItem(id : String) {
        Task {
            let result = await usecase.fetchItem(id: id)
            switch result {
            case .success(let product):
                DispatchQueue.main.async { // view는 메인 스레드에서 변경해야 함
                    self.item.accept(product.item.first ?? product.item[0])
//                    self.itemAndFavorite.accept(Observable.combineLatest(self.item, self.isFavorite))
                }
            case .failure(let error):
                self.error.accept(error.description)
            }

        }
    }
    
    private func checkFavoriteItem(id : String){
        let result = usecase.checkFavoriteItem(id: id)
        switch result {
        case .success(let success):
            if success {
                isFavorite.accept(true)
            } else {
                isFavorite.accept(false)
            }
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
    
    private func saveFavoriteItem(item : Product) {
        let result = usecase.saveFavoriteItem(item: item)
        switch result {
        case .success(_):
//            self.isFavorite.accept(true)
            self.itemAndFavorite.accept((item : item, isFavorite : true))
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
    
    private func deleteFavoriteItem(item : Product) {
        let result = usecase.deleteFavoriteItem(id: item.id)
        switch result {
        case .success(_):
//            self.isFavorite.accept(false)
            self.itemAndFavorite.accept((item : item, isFavorite : false))
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
}
