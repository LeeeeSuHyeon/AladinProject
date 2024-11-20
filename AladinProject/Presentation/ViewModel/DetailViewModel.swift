//
//  DetailViewModel.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import UIKit
import RxSwift
import RxCocoa


public struct DetailData {
    let item : Product
    let isFavorite : Bool
}


public protocol DetailViewModelProtocol {
    func transform(input : DetailViewModel.Input) -> DetailViewModel.Output
}

public class DetailViewModel : DetailViewModelProtocol {
    private let usecase : DetailUsecaseProtocol
    private let error = PublishRelay<String>()
    private let item = PublishRelay<Product>()
    private let isFavorite = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    init(usecase: DetailUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
        let saveItem : Observable<Product>
        let deleteItem : Observable<Product>
        let itemId : Observable<String>
    }
    
    public struct Output {
        let detailData : Observable<DetailData>
        let error : Observable<String>
    }
    
    public func transform(input: Input) -> Output {
        input.itemId.bind {[weak self] id in
            self?.fetchItem(id: id)
            self?.checkFavoriteItem(id: id)
        }.disposed(by: disposeBag)
        
        input.saveItem.bind {[weak self] item in
            self?.saveFavoriteItem(item: item)
        }.disposed(by: disposeBag)
        
        input.deleteItem.bind { [weak self] item in
            self?.deleteFavoriteItem(item: item)
        }.disposed(by: disposeBag)
        
        let detailData = Observable.combineLatest(item, isFavorite) { item, isFavorite in
            return DetailData(item: item, isFavorite: isFavorite)
        }

        return Output(detailData: detailData, error: self.error.asObservable())
    }
    
    private func fetchItem(id : String) {
        Task {
            let result = await usecase.fetchItem(id: id)
            switch result {
            case .success(let product):
                DispatchQueue.main.async { // view는 메인 스레드에서 변경해야 함
                    self.item.accept(product.item.first ?? product.item[0])
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
            self.isFavorite.accept(true)
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
    
    private func deleteFavoriteItem(item : Product) {
        let result = usecase.deleteFavoriteItem(id: item.id)
        switch result {
        case .success(_):
            self.isFavorite.accept(false)
        case .failure(let error):
            self.error.accept(error.description)
        }
    }
}

