//
//  MemorizeUser.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/08/24.
//

import Foundation
class MemorizeUser {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    init() {
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }
    
    public static let shared = {
        return MemorizeUser()
    }()
    
    func memorize(account: Account) -> Bool {
        if let encoded = try? encoder.encode(account) {
            UserDefaults.standard.setValue(encoded, forKey: Constants.USER.rawValue)
            return true;
        }
        return false
    }
    
    func unMemorize() -> Bool {
        UserDefaults.standard.removeObject(forKey: Constants.USER.rawValue)
        return true
    }
    
    func remind() -> Account? {
        if let data = UserDefaults.standard.data(forKey: Constants.USER.rawValue) {
            return try? decoder.decode(Account.self, from: data)
        }
        return nil
    }
}
class MemorizeProfile {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    init() {
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }
    
    public static let shared = {
        return MemorizeProfile()
    }()
    
    func memorize(profile: Profile?) -> Bool {
        if let encoded = try? encoder.encode(profile) {
            UserDefaults.standard.setValue(encoded, forKey: Constants.PROFILE.rawValue)
            return true;
        }
        return false
    }
    
    func unMemorize() -> Bool {
        UserDefaults.standard.removeObject(forKey: Constants.PROFILE.rawValue)
        return true
    }
    
    func remind() -> Profile? {
        if let data = UserDefaults.standard.data(forKey: Constants.PROFILE.rawValue) {
            return try? decoder.decode(Profile.self, from: data)
        }
        return nil
    }
}
