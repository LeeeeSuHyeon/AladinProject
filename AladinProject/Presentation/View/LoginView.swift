//
//  LoginView.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import UIKit

class LoginView : UIView {
    
    public let imgView = UIImageView().then { view in
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.backgroundColor = .red
    }
    
    public let btnKakaoLogin = UIButton().then { btn in
        btn.setImage(.kakaoLogin, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setSubView()
        setUI()
    }
    
    private func setSubView(){
        [
            imgView,
            btnKakaoLogin,
        ].forEach{self.addSubview($0)}
    }
    
    private func setUI(){
        imgView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.7)
        }
        
        btnKakaoLogin.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalTo(imgView.snp.bottom).offset(150)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
