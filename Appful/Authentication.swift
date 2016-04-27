//
//  Authentication.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import Foundation

//
// API
//

typealias JsonTaskCompletionHandler = (NSData?, NSURLResponse?, NSError?) -> Void

func fetchAuthenticationToken(email: String, _ password: String, _ completionHandler: JsonTaskCompletionHandler) {
    let request = authenticationRequest(email, password)
    guard let currentRequest = request else {
        print("authenticationResquest returned nil")
        return
    }
    let task = jsonDataTask(currentRequest, completionHandler: completionHandler)
    task.resume()
}

//
// Authentication Logic
//

private func authenticationRequest(email: String, _ password: String) -> NSURLRequest? {
    return jsonData(email, password).flatMap(
        jsonPostRequest("http://private-0299c-appfulapi.apiary-mock.com/login")
    )
}

//
// Primitive Components
//

private func jsonData(email: String, _ password: String) -> NSData? {
    let json = ["email": email, "password": password]
    do {
        return try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
    } catch {
        print(error)
        return nil
    }
}

private func jsonPostRequest(urlString: String) -> NSData -> NSURLRequest? {
    return { body in
        let url = NSURL(string: urlString)
        guard let currentURL = url else { return nil }
        let request = NSMutableURLRequest(URL: currentURL)
        request.HTTPMethod = "POST"
        request.HTTPBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

private func jsonDataTask(request: NSURLRequest, completionHandler: JsonTaskCompletionHandler) -> NSURLSessionDataTask {
    return NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: completionHandler)
}











