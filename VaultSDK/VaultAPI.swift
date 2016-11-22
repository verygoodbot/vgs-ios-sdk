//
//  VaultAPI.swift
//  VaultSDK
//
//  Created by Fang-Pen Lin on 11/22/16.
//  Copyright © 2016 Very Good Security. All rights reserved.
//

import Foundation

public class VaultAPI: NSObject {
    /// Base URL to the API server
    public var baseURL: NSURL
    /// The publishable key for tokenlizing senstive data to be stored in the vault
    public var publishableKey: String
    /// The URL session to be used for making HTTP requests
    public var urlSession: URLSession

    public init(
        baseURL: NSURL,
        publishableKey: String,
        urlSession: URLSession = URLSession.shared
    ) {
        self.baseURL = baseURL
        self.publishableKey = publishableKey
        self.urlSession = urlSession
    }

    /// Create a token for given senstive data
    ///  - Parameters payload: the payload of senstive data to be tokenlized
    ///  - Parameters success: the callback to be called with token data when we create successfully
    ///  - Parameters failure: the callback to be called with error when we failed to create
    public func createToken(
        payload: AnyObject,
        success: @escaping ([String: AnyObject]) -> Void,
        failure: @escaping (NSError) -> Void
    ) throws {
        let jsonObj: [String: AnyObject] = [
            "raw": payload as AnyObject
        ]
        let request = try makeRequest(method: "POST", path: "/tokens", jsonObj: jsonObj as AnyObject?)
        urlSession.dataTask(with: request!) { (data, response, error) in
            if let error = error {
                // TODO: convert the error here
                failure(error as NSError)
                return
            }
            // TODO: call success callback function here
        }
    }

    private func makeRequest(method: String, path: String, jsonObj: AnyObject?) throws -> URLRequest? {
        guard let url = baseURL.appendingPathComponent(path) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let obj = jsonObj {
            request.httpBody = try JSONSerialization.data(withJSONObject: obj, options: .init(rawValue: 0))
        }
        return request as URLRequest
    }
}
