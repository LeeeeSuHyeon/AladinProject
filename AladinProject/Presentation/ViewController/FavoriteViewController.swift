//
//  FavoriteViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/16/24.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteViewController: UIViewController {

    private let favoriteView = FavoriteView()
    private let viewModel : FavoriteViewModelProtocol
    private let deleteItem = PublishRelay<String>()
    private let viewLoad = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    private let itemList = BehaviorRelay<[FavoriteItem]>(value: [])
    
    init(){
        let favoriteRP = FavoriteRepository(coreData: FavoriteCoreData())
        let favoriteUC = FavoriteUsecase(repository: favoriteRP)
        viewModel = FavoriteViewModel(usecase: favoriteUC)
        
        super.init(nibName: nil, bundle: nil)
        
        view = favoriteView
        bindView()
        bindViewModel()
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
        viewLoad.accept(())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    
    private func bindView(){
        favoriteView.tableView.rx.itemSelected.bind{ index in
            guard let selectedId = self.itemList.value[index.row].id else {
                return
            }
                
            let nextVC = DetailViewController(id: selectedId)
            self.navigationController?.pushViewController(nextVC, animated: true)

        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel(){
        let input = FavoriteViewModel.Input(deleteItem: deleteItem.asObservable(), viewDidLoad: viewLoad.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.itemList
            .do { itemList in
                self.itemList.accept(itemList)
            }
            .bind(to: favoriteView.tableView.rx.items) { tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.id) as? FavoriteTableViewCell else {
                    return UITableViewCell()
                }

                cell.config(item: item)

                cell.btnSaved.rx.tap.bind { [weak self] in
                    guard let self = self else { return }
                    self.deleteItem.accept(item.id ?? "")
                }.disposed(by: cell.disposeBag)
                return cell
            }.disposed(by: disposeBag)
        
        output.error.bind { error in
            print(error)
        }.disposed(by: disposeBag)
    }
}
