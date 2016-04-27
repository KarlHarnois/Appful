//
//  UIApplication+ActivityIndicator.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import Foundation

extension UIApplication{
    static func showActivityIndicator() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
}