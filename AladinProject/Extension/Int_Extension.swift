//
//  Int_Extension.swift
//  AladinProject
//
//  Created by 이수현 on 11/13/24.
//

import Foundation

extension Int {
    func getWon() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let won = numberFormatter.string(for: self) ?? ""
        return won
    }
    
    func getWonString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let won = numberFormatter.string(for: self) ?? ""
        return won + "원"
    }
}
