//
//  KeychainService.swift
//  AladinProject
//
//  Created by 이수현 on 11/24/24.
//

import Foundation
import Security

class KeychainService {
    static let shared = KeychainService()
    
    private init() {}
    
    @discardableResult
    private func save(account : KeychainAccountType, service : KeychainServiceType, value : String) -> OSStatus {
        guard let valueData = value.data(using: .utf8) else {return errSecParam}
        
        let query : [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : account.rawValue,
            kSecAttrService as String : service.rawValue,
            kSecValueData as String : valueData
        ]
        
        SecItemDelete(query as CFDictionary) // 이미 있으면 삭제
        
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    @discardableResult
    private func load(account : KeychainAccountType, service : KeychainServiceType) -> String?{
        
        let query : [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : account.rawValue,
            kSecAttrService as String : service.rawValue,
            kSecReturnData as String : true,
            kSecMatchLimit as String : kSecMatchLimitOne // 결과 하나만 리턴
        ]
        
        var item : CFTypeRef?       // CFTypeRef 타입 == AnyObject 타입
        let osStatus = SecItemCopyMatching(query as CFDictionary, &item)
        
        if osStatus == errSecSuccess,
            let data = item as? Data,
            let value = String(data: data, encoding: .utf8) {
            return value
            
        } else {
            return nil
        }
    }
    
    @discardableResult
    private func update(account : KeychainAccountType, service : KeychainServiceType, newValue : String) -> OSStatus {
        
        guard let value = newValue.data(using: .utf8) else {return errSecParam}

        let query : [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : account.rawValue,
            kSecAttrService as String : service.rawValue,
        ]
        
        
        let attributesToUpdate : [String : Any] = [
            kSecValueData as String : value
        ]
        
        return SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
    }
    
    private func delete(account : KeychainAccountType, service : KeychainServiceType) -> OSStatus{
        
        let query : [String : Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : account.rawValue,
            kSecAttrService as String : service.rawValue
        ]
        
        return SecItemDelete(query as CFDictionary)
    }
}
