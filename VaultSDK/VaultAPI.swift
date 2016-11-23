//
//  VaultAPI.swift
//  VaultSDK
//
//  Created by Fang-Pen Lin on 11/22/16.
//  Copyright © 2016 Very Good Security. All rights reserved.
//

import Foundation

@objc
public enum VaultAPIError: Int {
    case noData
    case invalidData
    case badResponse
}

public class VaultAPI: NSObject {
    static let errorDomainSuffix = ".valut-api"

    /// Version of framework
    static var frameworkVersion: String? = {
        let bundle = Bundle(for: VaultAPI.self)
        return bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }()

    /// Build of framework
    static var frameworkBuild: String? = {
        let bundle = Bundle(for: VaultAPI.self)
        return bundle.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }()

    /// Base URL to the API server
    public var baseURL: URL
    /// The publishable key for tokenlizing senstive data to be stored in the vault
    public var publishableKey: String
    /// The URL session to be used for making HTTP requests
    public var urlSession: URLSession

    public init(
        baseURL: URL,
        publishableKey: String,
        urlSession: URLSession = URLSession.shared
    ) {
        self.baseURL = baseURL
        self.publishableKey = publishableKey
        self.urlSession = urlSession
    }

    /// Create a token for given senstive data
    ///  - Parameters payload: the payload of senstive data to be tokenlized
    ///  - Parameters failure: the callback to be called with error when we failed to create
    ///  - Parameters success: the callback to be called with token data when we create successfully
    ///  - Returns: the URLSessionTask for outgoing HTTP request
    @discardableResult
    public func createToken(
        payload: String,
        failure: @escaping (NSError) -> Void,
        success: @escaping ([String: AnyObject]) -> Void
    ) -> URLSessionTask {
        let jsonObj: [String: AnyObject] = [
            "raw": payload as AnyObject
        ]
        let request = try! makeRequest(method: "POST", path: "/tokens", jsonObj: jsonObj)
        let task = urlSession.dataTask(with: request!) { (data, response, error) in
            if let error = error {
                failure(error as NSError)
                return
            }
            let httpResponse = response as! HTTPURLResponse
            guard httpResponse.statusCode < 400 else {
                failure(VaultAPI.createError(
                    error: .badResponse,
                    userInfo: ["status_code": NSNumber(integerLiteral: httpResponse.statusCode)]
                ))
                return
            }
            guard let data = data else {
                failure(VaultAPI.createError(error: .noData))
                return
            }
            let jsonObj: Any
            do {
                jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            } catch {
                failure(VaultAPI.createError(error: .invalidData))
                return
            }
            success(jsonObj as! [String: AnyObject])
        }
        task.resume()
        return task
    }

    private func makeRequest(method: String, path: String, jsonObj: Any?) throws -> URLRequest? {
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let obj = jsonObj {
            request.httpBody = try JSONSerialization.data(withJSONObject: obj, options: .init(rawValue: 0))
        }
        if let version = VaultAPI.frameworkVersion, let build = VaultAPI.frameworkBuild {
            request.addValue(
                "Vault-iOS-SDK/\(version) (build \(build))",
                forHTTPHeaderField: "User-Agent"
            )
        }
        let basicAuth = "\(publishableKey):".data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(basicAuth)", forHTTPHeaderField: "Authorization")
        return request as URLRequest
    }

    private static func createError(
        error: VaultAPIError,
        userInfo: [String: AnyObject]? = nil
    ) -> NSError {
        return NSError(
            domain: VaultError.errorDomain + errorDomainSuffix,
            code: error.rawValue,
            userInfo: userInfo
        )
    }
}
