//
//  JsonLibrary.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import Foundation

//
// JSON
//

public typealias JsonDictionary = [String: AnyObject]

public func jsonData(dict: [String: String]) -> NSData? {
    do {
        return try NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted)
    } catch {
        print(error)
        return nil
    }
}

public func jsonDictionary(json: NSData) -> JsonDictionary? {
    do {
        return  try NSJSONSerialization.JSONObjectWithData(json, options: []) as? JsonDictionary
    } catch {
        print(error)
        return nil
    }
}

//
// Request
//

public func mutableRequest(urlString: String) -> NSMutableURLRequest? {
    let url = NSURL(string: urlString)
    guard let currentURL = url else { return nil }
    return  NSMutableURLRequest(URL: currentURL)
}

//
// Data task
//

public typealias JsonTaskCompletionHandler = (NSData?, NSURLResponse?, NSError?) -> Void

public func jsonDataTask(request: NSURLRequest, completionHandler: JsonTaskCompletionHandler) -> NSURLSessionDataTask {
    return NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: completionHandler)
}




