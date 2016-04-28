//
//  JsonLibraryTest.swift
//  Appful
//
//  Created by Karl Rivest Harnois on 16-04-27.
//  Copyright © 2016 Dynamo. All rights reserved.
//

import XCTest
import Appful

class JsonLibraryTest: XCTestCase {

    func testJsonData() {
        let testDictionary = ["testKey": "testValue"]
        let json = jsonData(testDictionary)
        let resultDictionary = jsonDictionary(json!)
        XCTAssertTrue(
            testDictionary["testKey"] == resultDictionary!["testKey"] as? String,
            "passing a dictionary into jsonData then back into jsonDictionary should return the same dictionary"
        )
    }
}
