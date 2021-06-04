//
//  AuthManager.swift
//  radioChat
//
//  Created by elliott on 6/1/21.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: String? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false 
    }
    
    
}
