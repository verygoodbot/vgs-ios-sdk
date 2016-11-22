//
//  VaultAPI.swift
//  VaultSDK
//
//  Created by Fang-Pen Lin on 11/22/16.
//  Copyright © 2016 Very Good Security. All rights reserved.
//

import Foundation

/// Base URL for production API server
public let kProductionBaseURL = NSURL(string: "https://api.verygoodvault.com")!
/// Base URL for sandbox API server
public let kSandBoxBaseURL = NSURL(string: "https://sandbox.verygoodvault.com")!

public class VaultAPI: NSObject {
    /// Base URL to the API server
    var baseURL: NSURL
    /// The publishable key for tokenlizing senstive data to be stored in the vault
    var publishableKey: String

    init(publishableKey: String, baseURL: NSURL = kProductionBaseURL) {
        self.baseURL = baseURL
        self.publishableKey = publishableKey
    }
}
