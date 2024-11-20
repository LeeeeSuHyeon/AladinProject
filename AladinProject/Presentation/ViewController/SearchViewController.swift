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

    private let searchView = SearchView()
    private let viewModel : SearchViewModelProtocol
    private let disposeBag = DisposeBag()
    private let itemList = PublishRelay<[Product]>()
    private let fetchMore = PublishRelay<Void>()
    
    init(){
        let searchNM = NetworkManager(session: SearchSession())
        let searchNetwork = SearchNetwork(manager: searchNM)
        let searchCD = SearchCoreData()
        let searchRP = SearchRepository(coreData: searchCD, network: searchNetwork)
        let searchUC = SearchUsecase(repository: searchRP)
        viewModel = SearchViewModel(usecase: searchUC)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = searchView
        bindViewModel()
        bindView()
    }
    
    private func bindView(){
        searchView.btnDismiss.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true)
        }.disposed(by: disposeBag)
        
        searchView.tableView.rx.willDisplayCell.bind {[weak self] cell, indexPath in
            guard let self = self else {return}
            let row = self.searchView.tableView.numberOfRows(inSection: 0)
            print("row : \(row), indexPath : \(indexPath.row)")
            if row - indexPath.row < 3 {
                self.fetchMore.accept(())
            }
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel(){
        let query = searchView.txtSearch.rx.text.orEmpty.debounce(.milliseconds(300), scheduler: MainScheduler.instance)
        let output = viewModel.transform(input: SearchViewModel.Input(
            query: query,
            fetchMore: fetchMore.asObservable()

        ))
        output.itemList.bind(to: searchView.tableView.rx.items) { tableView, indexPath, item in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id) as? SearchTableViewCell else {
                return UITableViewCell()
            }
            
            cell.config(item: item)
            return cell
            
        }.disposed(by: disposeBag)
    }
}
