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
    private let bestSellerList = PublishRelay<[Book]>()
    private let newBookList = PublishRelay<[Book]>()
//    private var page = 0
    
    init(usecase: HomeUsecaseProtocol) {
        self.usecase = usecase
    }
    
    public struct Input {
//        let query : Observable<String> // 사용자 검색 쿼리
//        let selectedBook : Observable<Int> // 책 선택 (책 아이디)
//        let selectedCategory : Observable<String> // 카테고리 선택
        let viewDidLoad : Observable<Void>
//        let fetchMore : Observable<Void>
    }
    
    public struct Output {
//        let bookList : Observable<Result<BookList, Error>>
        let bestSellerList : Observable<[Book]>
        let newBookList : Observable<[Book]>
        let error : Observable<String>
//        let searchResult : Observable<[Book]>
//        let selectedBookId : Observable<Int>
//        let selectedCategory : Observable<String>
    }
    
    public func transfrom(input : Input) -> Output {
//        input.query.bind {[weak self] query in
//            self?.fetchBook(query : query)
//        }.disposed(by: disposeBag)
//        
//        input.selectedBook.bind {[weak self] bookId in
//            self?.fetchBook(bookId : bookId)
//        }.disposed(by: disposeBag)
//        
//        input.selectedCategory.bind { [weak self] category in
//            self?.fetchCategory(category: category)
//        }.disposed(by: disposeBag)
        
        input.viewDidLoad.bind { [weak self] in
            self?.fetchBook()
        }.disposed(by: disposeBag)

        return Output(bestSellerList: self.bestSellerList.asObservable(), newBookList: self.newBookList.asObservable(), error: error.asObservable())
    }
    
    private func fetchBook(query : String){}
    
    private func fetchBook(bookId : Int){}
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
    private func fetchCategory(category : String){}
    
}
