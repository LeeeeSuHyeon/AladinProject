//
//  ViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    let viewModel : HomeViewModelProtocol
    let disposeBag = DisposeBag()
    let homeView : HomeView
    
    private var datasource : UICollectionViewDiffableDataSource<Section, Item>?
    
    init() {
        let homeSession = HomeSession()
        let networkManager = NetworkManager(session: homeSession)
        let homeNetwork = HomeNetwork(manage: networkManager)
        let homeRP = HomeRespository(network: homeNetwork)
        let homeUC = HomeUsecase(repository: homeRP)
        self.viewModel = HomeViewModel(usecase: homeUC)
        self.homeView = HomeView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view = homeView

        setDataSource()
        bindViewModel()
        bindView()
    }
    
    private func setDataSource(){
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: homeView.collectionView, cellProvider: { collectionView, indexPath, item in
            switch item {
            case .newBook(let book):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeNewBookCollectionViewCell.id, for: indexPath) as? HomeNewBookCollectionViewCell else {return UICollectionViewCell()}
                cell.config(imageURL: book.coverURL, title: book.title)
                return cell
            case .category(let category):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCollectionViewCell.id, for: indexPath) as? HomeCategoryCollectionViewCell else {return UICollectionViewCell()}
                cell.config(imgURL: category.image, title: category.title)
                return cell
            case .bestSeller(let book) :
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBestSellerCollectionViewCell.id, for: indexPath) as? HomeBestSellerCollectionViewCell else {return UICollectionViewCell()}
                cell.config(imgURL: book.coverURL, title: book.title, author: book.author)
                return cell
            }
            
        })
        if let datasource = datasource {
            homeView.config(dataSource: datasource)
        }
        
    }
    
    private func bindView(){
        
    }
    
    private func bindViewModel(){
        let output = viewModel.transfrom(input: HomeViewModel.Input(viewDidLoad: Observable.just(Void())))
        
        let _ = Observable.combineLatest(output.bestSellerList, output.newBookList).bind {[weak self] bestSellerList, newBookList in
            var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
            
            let bannerSection = Section.banner
            let bannerItem = newBookList.map{Item.newBook($0)}
            
            let doubleSection = Section.double
            let doubleItem = bestSellerList.map{Item.bestSeller($0)}
            
            snapShot.appendSections([bannerSection, doubleSection])
            snapShot.appendItems(doubleItem, toSection: doubleSection)
            snapShot.appendItems(bannerItem, toSection: bannerSection)
            
            self?.datasource?.apply(snapShot)
        }.disposed(by: disposeBag)
        
//        output.bestSellerList.bind(onNext: { bookList in
//            print(bookList)
//            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//            let section = Section.double
//            let items = bookList.map {Item.bestSeller($0)}
//            snapshot.appendSections([section])
//            snapshot.appendItems(items, toSection: section)
//            self.datasource?.apply(snapshot)
//        }).disposed(by: disposeBag)
//        
//        output.newBookList.bind { bookList in
//            print(bookList)
//            var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//            let section = Section.banner
//            let items = bookList.map{Item.newBook($0)}
//            snapshot.appendSections([section])
//            snapshot.appendItems(items, toSection: section)
//            self.datasource?.apply(snapshot)
//        }.disposed(by: disposeBag)
    }

//    private func test(){
//
//        Task {
//            let result = await homeUC.fetchBestSellerList()
//            switch result {
//            case .success(let data):
//                print(data.item)
//            case .failure(let error):
//                print(error.description)
//            }
//        }
//    }

}

