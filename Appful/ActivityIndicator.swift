//
//  ActivityIndicator.swift
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
