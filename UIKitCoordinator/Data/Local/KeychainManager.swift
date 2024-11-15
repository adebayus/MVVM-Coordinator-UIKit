//
//  KeychainManager.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 15/11/24.
//

import Foundation
import SwiftKeychainWrapper


extension KeychainWrapper.Key {
    static let todo: KeychainWrapper.Key = "TODO"
    static let token: KeychainWrapper.Key = "TOKEN"
}

final class KeychainManager {
    
    static let shared = KeychainManager()
    
    func setToken(value: String) {
        KeychainWrapper.standard[.token] = value
    }
    
    func getToken() -> String? {
        let result: String? = KeychainWrapper.standard[.token]
        return result
    }
    
    func setTodo(value: Todo) {
        guard let encode = encode(object: value) else { return }
        KeychainWrapper.standard[.todo] = encode
    }
    
    func getTodo() -> Todo? {
        guard let data: Data = KeychainWrapper.standard[.todo] else { return nil }
        guard let decoded = decode(json: data, as: Todo.self) else { return nil }
        return decoded
    }
}

extension KeychainManager {
    
    
    private func decode<T: Decodable>(json: Data, as clazz: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(T.self, from: json)
            
            return data
        } catch {
            print("An error occurred while parsing JSON")
        }
        
        return nil
    }
    
    private func encode<T: Codable>(object: T) -> Data? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(object)
        } catch let error {
            print(error.localizedDescription, "errorEncoded")
        }
        return nil
    }
}
