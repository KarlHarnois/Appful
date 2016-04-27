//
//  Account.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import Foundation

//
// API
//

typealias User = (firstName: String, lastName: String)

func fetchAccount(token: String, _ completionHandler: JsonTaskCompletionHandler) {
    fetchAccountDataTask(token, completionHandler)?.resume()
}

func userModel(json: NSData) -> User? {
    return jsonDictionary(json).flatMap{ dictionary in
        guard let firstName = dictionary["first_name"] as? String else { return nil }
        guard let lastName = dictionary["last_name"] as? String else { return nil }
        return (firstName, lastName)
    }
}

// 
// Account Logic
//


private func fetchAccountDataTask(token: String, _ completionHandler: JsonTaskCompletionHandler) -> NSURLSessionDataTask? {
    return jsonTokenRequest("http://private-0299c-appfulapi.apiary-mock.com/me", token).flatMap{ request in
        NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: completionHandler)
    }
}

private func jsonTokenRequest(url: String, _ token: String) -> NSURLRequest? {
    let request = mutableRequest(url)
    request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request?.setValue("Token " + token, forHTTPHeaderField: "Authorization")
    return request
}











