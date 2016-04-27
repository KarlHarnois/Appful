//
//  AuthenticationManager.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import Foundation

protocol AuthenticationDelegate {
    func authenticationResult(user: User?)
}

class AuthenticationManager {
    
    private let delegate: AuthenticationDelegate
    
    init(delegate: AuthenticationDelegate){
        self.delegate = delegate
    }
    
    func authentication(email: String, _ password: String) {
        fetchToken(email, password){ data, _, error in
            if let err = error {
                print(err)
                self.delegate.authenticationResult(nil)
            } else if let jsonData = data{
                if let authenticationToken = token(jsonData) {
                    self.fetchUser(authenticationToken)
                } else {
                    self.delegate.authenticationResult(nil)
                }
            } else {
                self.delegate.authenticationResult(nil)
            }
        }
    }
    
    private func fetchUser(token: String) {
        fetchAccount(token) { data, _, error in
            if let err = error {
                print(err)
                self.delegate.authenticationResult(nil)
            } else if let jsonData = data {
                if let user = userModel(jsonData) {
                    self.delegate.authenticationResult(user)
                } else {
                    self.delegate.authenticationResult(nil)
                }
            } else {
                self.delegate.authenticationResult(nil)
            }
        }
    }
}


