//
//  AccountTest.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-28.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import XCTest
import Appful

class AccountTest: XCTestCase {
    
    let testEmail = "hugo@godynamo.com"
    let testPassword = "123456"
    let testFirstName = "Hugo"
    let testLastName = "Bastien"
    
    func testFetchAccount(){
        let tokenFetching = fetchToken(testEmail, testPassword) { data, _, _ in
            let currentToken = token(data!)!
            let accountFetching = fetchAccount(currentToken) { data, response, error in
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                XCTAssertTrue(statusCode == 200, "fetchAccount() status code should be 200 for test email/password")
                XCTAssertTrue(data != nil, "fetchAccount() should return user data for test email/password")
                XCTAssertTrue(self.testFirstName == userModel(data!)?.firstName &&
                              self.testLastName  == userModel(data!)?.lastName,
                              "fetchAccount() data should return testFirstName and testLastName when applying userModel function")
                XCTAssertNil(error, "fetchAccount() error should be nil")
            }
            accountFetching?.resume()
            XCTAssertTrue(accountFetching != nil, "fetchAccount() should return NSURLSessionDataTask")
        }
        tokenFetching?.resume()
        XCTAssertTrue(tokenFetching != nil, "fetchToken() should return NSURLSessionDataTask")
    }
}