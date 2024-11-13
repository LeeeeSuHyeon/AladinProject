//
//  HomeView.swift
//  AladinProject
//
//  Created by 이수현 on 11/12/24.
//

import UIKit
import Then
import SnapKit

enum Section : Hashable{
    case banner
    case flow
    case double
}

enum Item : Hashable {
    case newBook(Book)
    case category(Category)
    case bestSeller(Book)
}


class HomeView : UIView {
    private var dataSource : UICollectionViewDiffableDataSource<Section, Item>?
    
    let textSearch = UITextField().then { text in
        text.placeholder = "원하시는 책을 검색해주세요."
        text.font = .systemFont(ofSize: 14)
        let imgView = UIImageView(image: .init(systemName: "magnifyingglass"))
        imgView.frame = CGRect(x: 0, y: 0, width: 10, height: 0)
        text.leftView = imgView
        text.leftViewMode = .always
        text.backgroundColor = .systemGray5
        text.layer.cornerRadius = 10
        text.tintColor = .black
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then { view in
        view.register(HomeNewBookCollectionViewCell.self, forCellWithReuseIdentifier: HomeNewBookCollectionViewCell.id)
        view.register(HomeCategoryCollectionViewCell.self, forCellWithReuseIdentifier: HomeCategoryCollectionViewCell.id)
        view.register(HomeBestSellerCollectionViewCell.self, forCellWithReuseIdentifier: HomeBestSellerCollectionViewCell.id)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUI()
    }
    
    private func setUI(){
        addSubview(textSearch)
        addSubview(collectionView)
        
        textSearch.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textSearch.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout{
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 14
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .banner : return self?.createBannerSection()
            case .flow : return self?.createFlowSection()
            case .double : return self?.createDoubleSection()
            default:
                return self?.createBannerSection()
            }
        }, configuration: config)
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom:0, trailing: 15)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createFlowSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    private func createDoubleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(280))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none

        return section
    }
    
    public func config(dataSource : UICollectionViewDiffableDataSource<Section, Item>) {
        self.dataSource = dataSource
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
