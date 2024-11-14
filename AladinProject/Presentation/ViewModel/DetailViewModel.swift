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
//    func transform(input : DetailViewModel.Input) -> DetailViewModel.Output
}

public class DetailViewModel : DetailViewModelProtocol {
    private let usecase : DetailUsecaseProtocol
    private let error = PublishRelay<String>()
    private let item = PublishRelay<Product>()
    private let disposeBag = DisposeBag()
    private let id : String
    
    
    init(usecase: DetailUsecaseProtocol, id : String) {
        self.usecase = usecase
        self.id = id
    }
    
    public struct Input {
        let saveItem : Observable<Product>
        let deleteItem : Observable<Int>
        let clickLink : Observable<String>
        let purchaseItem : Observable<Void>
    }
    
    public struct Output {
        let item : Observable<Product>
        let error : Observable<Error>
    }
    
    public func transform(input: Input) -> Output {
        
        Task {
            do {
                let output = try await usecase.fetchItem(id: id)
                item.accept(output)
            } catch  {
                self.error.accept(error.localizedDescription)
            }
        }
        return Output(item: output, error: <#T##Observable<any Error>#>)
    }
    
}
