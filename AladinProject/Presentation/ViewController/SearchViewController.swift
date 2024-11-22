//
//  SearchViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    private var dataSource : UICollectionViewDiffableDataSource<SearchSection, SearchItem>?

    private let searchView = SearchView()
    private let viewModel : SearchViewModelProtocol
    private let disposeBag = DisposeBag()
    private let itemList = PublishRelay<[Product]>()
    private let loadRecord = PublishRelay<Void>()
    private let fetchMore = PublishRelay<Void>()
    
    init(){
        let searchNM = NetworkManager(session: SearchSession())
        let searchNetwork = SearchNetwork(manager: searchNM)
        let searchCD = SearchCoreData()
        let searchRP = SearchRepository(coreData: searchCD, network: searchNetwork)
        let searchUC = SearchUsecase(repository: searchRP)
        viewModel = SearchViewModel(usecase: searchUC)
        super.init(nibName: nil, bundle: nil)
        
        
        self.view = searchView
        bindViewModel()
        bindView()
        setDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bindView(){
        searchView.btnDismiss.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true)
        }.disposed(by: disposeBag)
        
        searchView.collectionView.rx.willDisplayCell.bind {[weak self] cell, indexPath in
            guard let self = self else {return}
            let row = self.searchView.collectionView.numberOfItems(inSection: 1)
            print("row : \(row), indexPath : \(indexPath.row)")
            if row - indexPath.row < 3 {
                self.fetchMore.accept(())
            }
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel(){
        let query = searchView.txtSearch.rx.text.orEmpty.debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        let output = viewModel.transform(input: SearchViewModel.Input(
            loadRecord : Observable.just(()), query: query,
            fetchMore: fetchMore.asObservable()
        ))
        
        Observable.combineLatest(output.itemList, output.searchRecord).bind {[weak self] itemList, searchRecordList in
            print("itemList : \(itemList.count)")
            guard let self = self else {return}
            var snapShot = NSDiffableDataSourceSnapshot<SearchSection, SearchItem>()
            
            let horizontalSection = SearchSection.horizontal
            let horizontalItem = searchRecordList.map{SearchItem.searchRecord($0)}
            
            let verticalSection = SearchSection.vertical
            let verticalItem = itemList.map{SearchItem.searchResult($0)}
            
            snapShot.deleteAllItems()
            snapShot.appendSections([horizontalSection, verticalSection])
            snapShot.appendItems(horizontalItem, toSection: horizontalSection)
            snapShot.appendItems(verticalItem, toSection: verticalSection)

            self.dataSource?.apply(snapShot)
            
        }.disposed(by: disposeBag)
        
//        output.itemList
//            .bind {[weak self] itemList in
//            guard let self = self else {return}
//            var snapShot = NSDiffableDataSourceSnapshot<SearchSection, SearchItem>()
//            let verticalSection = SearchSection.vertical
//            snapShot.appendSections([verticalSection])
//            let item = itemList.map{SearchItem.searchResult($0)}
//            snapShot.appendItems(item, toSection: verticalSection)
//            
//            self.dataSource?.apply(snapShot)
//            
//        }.disposed(by: disposeBag)
//        
//        output.searchRecord.bind {[weak self] searchRecordList in
//            guard let self = self else {return}
//            var snapShot = NSDiffableDataSourceSnapshot<SearchSection, SearchItem>()
//            let horizontalSection = SearchSection.horizontal
//            let item = searchRecordList.map{SearchItem.searchRecord($0)}
//            snapShot.appendSections([horizontalSection])
//            snapShot.appendItems(item, toSection: horizontalSection)
//            
//            self.dataSource?.apply(snapShot)
//        }.disposed(by: disposeBag)

    }
    
    private func setDataSource(){
        dataSource = UICollectionViewDiffableDataSource<SearchSection, SearchItem>(collectionView: searchView.collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .searchRecord(let title) :
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchRecordCell.id, for: indexPath) as? SearchRecordCell else {
                    return UICollectionViewCell()
                }
                cell.config(title: title)
                return cell
            case .searchResult(let item) :
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.config(item: item)
                return cell
            }
        })
        
        if let dataSource = dataSource {
            searchView.config(dataSource: dataSource)
        }
    }
}
