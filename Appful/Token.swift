//
//  Token.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import Foundation

//
// API
//

func fetchToken(email: String, _ password: String, _ completionHandler: JsonTaskCompletionHandler) {
    fetchTokenDataTask(email, password, completionHandler)?.resume()
}

func token(json: NSData) -> String? {
    return jsonDictionary(json).flatMap{ dictionary in
        dictionary["token"] as? String
    }
}

//
// Authentication Logic
//

private func fetchTokenDataTask(email: String,
                              _ password: String,
                              _ completionHandler: JsonTaskCompletionHandler) -> NSURLSessionDataTask? {
    return authenticationRequest(email, password).flatMap{ request in
        jsonDataTask(request, completionHandler: completionHandler)
    }
}

private func authenticationRequest(email: String, _ password: String) -> NSURLRequest? {
    let dictionary = ["email": email, "password": password]
    return jsonData(dictionary).flatMap(
        jsonTokenPostRequest("http://private-0299c-appfulapi.apiary-mock.com/login")
    )
}

private func jsonTokenPostRequest(url: String) -> NSData -> NSURLRequest? {
    return { body in
        let request = mutableRequest(url)
        request?.HTTPMethod = "POST"
        request?.HTTPBody = body
        request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}












