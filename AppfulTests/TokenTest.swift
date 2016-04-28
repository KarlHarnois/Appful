//
//  TokenTest.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-28.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import XCTest
import Appful

class TokenTest: XCTestCase {
    func testFetchToken(){
        let testEmail = "hugo@godynamo.com"
        let testPassword = "123456"
        let testToken = "9SNq/xFu/IPITXwQidPugg=="
        let fetch = fetchToken(testEmail, testPassword) { data, response, error in
            let statusCode = (response as! NSHTTPURLResponse).statusCode
            XCTAssertTrue(statusCode == 200, "fetchToken() status code should be 200 for test email/password")
            XCTAssertTrue(data != nil, "fetchToken() should return token data for test email/password")
            XCTAssertTrue(testToken == token(data!), "fetchToken() data should return testToken when applying token function")
            XCTAssertNil(error, "fetchToken() error should be nil")
        }
        fetch?.resume()
        XCTAssertTrue(fetch != nil, "fetchToken() should return NSURLSessionDataTask")
    }
}
