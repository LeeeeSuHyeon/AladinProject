//
//  ViewController.swift
//  AladinProject
//
//  Created by 이수현 on 11/11/24.
//

import UIKit
import RxSwift
import RxCocoa

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
                cell.config(imgURL: category.imageURL, title: category.title)
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
        
        datasource?.supplementaryViewProvider = {[weak self] (collectionView, kind, indexPath) in
            
            let section = self?.datasource?.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .banner(let header):
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeaderView.id, for: indexPath)
                (headerView as? HomeHeaderView)?.config(header: header)
                return headerView
            case .flow(let header):
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeaderView.id, for: indexPath)
                (headerView as? HomeHeaderView)?.config(header: header)
                return headerView
            case .double(let header):
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeaderView.id, for: indexPath)
                (headerView as? HomeHeaderView)?.config(header: header)
                return headerView
            default:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeaderView.id, for: indexPath)
                (headerView as? HomeHeaderView)?.config(header: "헤더 없음")
                return headerView
            }
            
        }
        
    }
    
    private func bindView(){
        self.homeView.collectionView.rx.itemSelected.bind { indexPath in
            let item = self.datasource?.itemIdentifier(for: indexPath)
            
            switch item {
            case .newBook(let product):
                let id = product.id
                let nextVC = DetailViewController(id: id)
                self.present(nextVC, animated: true)
            case .category(let category):
                <#code#>
            case .bestSeller(let product):
                <#code#>
            case nil:
                <#code#>
            }
            
            
            
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel(){
        let output = viewModel.transfrom(input: HomeViewModel.Input(viewDidLoad: Observable.just(Void())))
        
        let _ = Observable.combineLatest(output.bestSellerList, output.newBookList).bind {[weak self] bestSellerList, newBookList in
            var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
            
            let bannerSection = Section.banner("신간 도서")
            let bannerItem = newBookList.map{Item.newBook($0)}
            
            let doubleSection = Section.double("인기 도서")
            let doubleItem = bestSellerList.map{Item.bestSeller($0)}
            
            let flowSection = Section.flow("카테고리")
            let flowItem = Category.dummy().map{Item.category($0)}
            
            snapShot.appendSections([bannerSection, flowSection, doubleSection])
            snapShot.appendItems(doubleItem, toSection: doubleSection)
            snapShot.appendItems(bannerItem, toSection: bannerSection)
            snapShot.appendItems(flowItem, toSection: flowSection)
            
            self?.datasource?.apply(snapShot)
        }.disposed(by: disposeBag)
    }
}

