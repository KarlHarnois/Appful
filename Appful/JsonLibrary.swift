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

typealias JsonDictionary = [String: AnyObject]

func jsonDictionary(json: NSData) -> JsonDictionary? {
    do {
        return  try NSJSONSerialization.JSONObjectWithData(json, options: []) as? JsonDictionary
    } catch {
        print(error)
        return nil
    }
}

func jsonData(dict: [String: String]) -> NSData? {
    do {
        return try NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted)
    } catch {
        print(error)
        return nil
    }
}


//
// Request
//

func mutableRequest(urlString: String) -> NSMutableURLRequest? {
    let url = NSURL(string: urlString)
    guard let currentURL = url else { return nil }
    return  NSMutableURLRequest(URL: currentURL)
}

//
// Data task
//

typealias JsonTaskCompletionHandler = (NSData?, NSURLResponse?, NSError?) -> Void

func jsonDataTask(request: NSURLRequest, completionHandler: JsonTaskCompletionHandler) -> NSURLSessionDataTask {
    return NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: completionHandler)
}




