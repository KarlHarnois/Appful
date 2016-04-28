//
//  AuthenticationTest.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-28.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import XCTest
import Appful

class AuthenticationTest: XCTestCase {
    
    let observable = authentication("hugo@godynamo.com", "123456")
    let testFirstName = "Hugo"
    let testLastName = "Bastien"
    
    func testAuthentication() {
        var flag = false
        observable
            .onStart{
                flag = true
            }
            .onSuccess{ user in
                XCTAssertTrue(user?.firstName == self.testFirstName, "observable should return user with testUserFirstName")
                XCTAssertTrue(user?.lastName == self.testLastName, "observable should return user with testLastName")
            }
        XCTAssertTrue(flag, "Observable.onStart() should execute callback on instant")
    }
}

