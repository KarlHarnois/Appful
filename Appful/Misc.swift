//
//  Misc.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import UIKit

struct ActivityIndicator {
    static func show() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    static func hide() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}

func mainQueue(callback: () -> Void) {
    dispatch_sync(dispatch_get_main_queue()) {
        callback()
    }
}

func alertController(title: String, _ message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let dismiss = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
    alert.addAction(dismiss)
    return alert
}
