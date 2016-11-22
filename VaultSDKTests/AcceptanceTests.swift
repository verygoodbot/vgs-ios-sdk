//
//  AcceptanceTests.swift
//  VaultSDK
//
//  Created by Fang-Pen Lin on 11/22/16.
//  Copyright © 2016 Very Good Security. All rights reserved.
//

import XCTest

@testable import VaultSDK

class AcceptanceTests: XCTestCase {
    static let baseURL = NSURL(string: "https://demo.sandbox.verygoodvault.com")!
    static let publishableKey = "demo-user"

    var api: VaultAPI!

    override func setUp() {
        super.setUp()
        api = VaultAPI(
            baseURL: AcceptanceTests.baseURL,
            publishableKey: AcceptanceTests.publishableKey
        )
    }

    func testCreateToken() {
        let exp = expectation(description: "token created")
        do {
            try api.createToken(
                payload: "4111111111111111",
                failure: { error in
                    XCTFail("Failed to create token, error=\(error)")
                    exp.fulfill()
                },
                success: { token in
                    print("@@@@@ \(token)")
                    exp.fulfill()
                }
            )
            waitForExpectations(timeout: 30, handler: nil)
        } catch {
            XCTFail("Failed to create token, error=\(error)")
        }
    }
}
