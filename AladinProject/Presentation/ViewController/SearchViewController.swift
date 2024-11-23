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
    private let itemList = BehaviorRelay<[Product]>(value: [])
    private let loadRecord = PublishRelay<Void>()
    private let fetchMore = BehaviorRelay<Void>(value: ())
    private let deleteTitle = PublishRelay<String>()
    private let deleteAll = PublishRelay<Void>()
    
    init(){
        let searchNM = NetworkManager(session: SearchSession())
        let searchNetwork = SearchNetwork(manager: searchNM)
        let searchCD = SearchCoreData()
        let searchRP = SearchRepository(coreData: searchCD, network: searchNetwork)
        let searchUC = SearchUsecase(repository: searchRP)
        viewModel = SearchViewModel(usecase: searchUC)
        super.init(nibName: nil, bundle: nil)
        
        
        self.view = searchView
        setDataSource()
        bindViewModel()
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    private func bindView(){
        searchView.btnDismiss.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true)
        }.disposed(by: disposeBag)
        
        searchView.collectionView.rx.willDisplayCell.bind {[weak self] cell, indexPath in
            guard let self = self else {return}
            
            if indexPath.section == 1 {
                let row = self.searchView.collectionView.numberOfItems(inSection: 1)
                print("row : \(row), indexPath : \(indexPath.row)")
                if row - indexPath.row < 3 {
                    self.fetchMore.accept(())
                }
            }
        }.disposed(by: disposeBag)
        
        searchView.collectionView.rx.itemSelected.bind {[weak self] indexPath in
            let data = self?.dataSource?.itemIdentifier(for: indexPath)
            switch data {
            case .searchRecord(let title):
                self?.searchView.txtSearch.text = title
                self?.searchView.txtSearch.becomeFirstResponder()
            case .searchResult(let item):
                let selectedId = item.id
                let nextVC = DetailViewController(id: selectedId)
                self?.navigationController?.pushViewController(nextVC, animated: true)
            case .none:
                return
            }
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel(){
        let query = searchView.txtSearch.rx.text.orEmpty.debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        let output = viewModel.transform(input: SearchViewModel.Input(
            loadRecord : Observable.just(()), query: query,
            fetchMore: fetchMore.asObservable(), deleteTitle: deleteTitle.asObservable(), deleteAll: deleteAll.asObservable()
        ))
        
        Observable.combineLatest(output.itemList, output.searchRecord)
            .observe(on: MainScheduler.instance)
            .bind {[weak self] itemList, searchRecordList in
                print("itemList : \(itemList.count)")
                print("searchRecordList : \(searchRecordList.count)")
                guard let self = self else {return}
                var snapShot = self.dataSource?.snapshot() ??  NSDiffableDataSourceSnapshot<SearchSection, SearchItem>()

                snapShot.deleteAllItems()
   
                let horizontalSection = SearchSection.horizontal
                let horizontalItem = searchRecordList.map{SearchItem.searchRecord($0)}
                
                let verticalSection = SearchSection.vertical
                let verticalItem = itemList.map{SearchItem.searchResult($0)}
                
                snapShot.appendSections([horizontalSection, verticalSection])
                snapShot.appendItems(horizontalItem, toSection: horizontalSection)
                snapShot.appendItems(verticalItem, toSection: verticalSection)
            
                self.dataSource?.apply(snapShot)
                
        }.disposed(by: disposeBag)
        

    }
    
    private func setDataSource(){
        dataSource = UICollectionViewDiffableDataSource<SearchSection, SearchItem>(collectionView: searchView.collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .searchRecord(let title) :
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchRecordCell.id, for: indexPath) as? SearchRecordCell else {
                    return UICollectionViewCell()
                }
                cell.config(title: title)
                
                cell.btnRemove.rx.tap.bind {[weak self] in
                    self?.deleteTitle.accept(title)
                }.disposed(by: self.disposeBag)
                
                return cell
            case .searchResult(let item) :
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.config(item: item)
                return cell
            }
        })
        
        
        dataSource?.supplementaryViewProvider = { collectionview, kind, indexPath in
            let section = self.dataSource?.sectionIdentifier(for: indexPath.section)
            switch section {
            case .horizontal:
                let header = collectionview.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchRecordHeaderView.id, for: indexPath) as? SearchRecordHeaderView
                header?.btnAllDelete.rx.tap.bind{[weak self] _ in
                    print("btnAllDelete - tap")
                    self?.deleteAll.accept(())
                }.disposed(by: self.disposeBag)
                return header
            case .vertical:
                return nil
            case .none:
                return nil
            }
        }
        
        if let dataSource = dataSource {
            searchView.config(dataSource: dataSource)
        }
        
    }
}
