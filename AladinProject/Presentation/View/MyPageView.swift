//
//  MyPageView.swift
//  AladinProject
//
//  Created by 이수현 on 11/25/24.
//

import UIKit

class MyPageView : UIView {
    
    private let profileImageView = UIImageView().then { view in
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
    }
    
    private let grpInfo = UIStackView().then { view in
        view.axis = .vertical
        view.spacing = 8
    }
    
    private let nicknameLabel = UILabel().then { lbl in
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.numberOfLines = 1
    }
    
    private let accountLabel = UILabel().then { lbl in
        lbl.font = .systemFont(ofSize: 15, weight: .bold)
        lbl.numberOfLines = 1
        lbl.textColor = .systemGray4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubView()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setSubView(){
        [
            nicknameLabel,
            accountLabel
        ].forEach{grpInfo.addArrangedSubview($0)}
            
        [
            profileImageView,
            grpInfo
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(20)
            make.width.height.equalTo(100)
        }
        
        grpInfo.snp.makeConstraints { make in
            make.top.bottom.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
        }
        
        accountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
    }
    
    public func config(profileImage : URL?, nickname : String, account : String) {
        self.profileImageView.kf.setImage(with: profileImage, placeholder: UIImage(systemName: "person"))
        self.nicknameLabel.text = nickname
        self.accountLabel.text = account
    }
    
    
}

