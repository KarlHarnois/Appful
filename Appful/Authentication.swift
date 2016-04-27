//
//  Authentication.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import Foundation

func authentication(email: String, _ password: String) -> Observable<User?>{
    return tokenObservable(email, password).flatMap(userObservable)
}

private func tokenObservable(email: String, _ password: String) -> Observable<String> {
    return Observable.create{ observer in
        fetchToken(email, password){ data, _, error in
            if let err = error {
                observer.error = err
            } else if let jsonData = data{
                if let authenticationToken = token(jsonData) {
                    observer.success = authenticationToken
                }
            } else {
                observer.complete = true
            }
        }
    }
}

private func userObservable(token: String) -> Observable<User?> {
    return Observable.create{ observer in
        fetchAccount(token) { data, _, error in
            if let err = error {
                observer.error = err
            } else if let jsonData = data {
                if let user = userModel(jsonData) {
                    observer.success = user
                }
            }
            observer.complete = true
        }
    }
}







