# vgs-ios-sdk
[![Build Status](https://travis-ci.org/verygoodsecurity/vgs-ios-sdk.svg?branch=rewrite)](https://travis-ci.org/verygoodsecurity/vgs-ios-sdk)
[![license](https://img.shields.io/github/license/verygoodsecurity/vgs-ios-sdk.svg)]()

Very Good Security Vault iOS SDK

## Requirements

This SDK is written in Swift 3.0, it requires Xcode 8.0 or above.

## Usage example in Swift 3.0

```Swift
import VaultSDK

let api = VaultAPI(
    baseURL: URL(string: "https://demo.sandbox.verygoodvault.com")!,
    publishableKey: "demo-user"
)
api.createToken(
    payload: "4111111111111111",
    failure: { error in
        // Handle the error here
    },
    success: { token in
        // Use the token here
    }
)
 ```

## Usage example in Objective C

Import the SDK like this

```ObjectiveC
@import VaultSDK;
```

then

```ObjectiveC
VaultAPI *api = [[VaultAPI alloc] initWithBaseURL:[NSURL URLWithString:@"https://demo.sandbox.verygoodvault.com"] publishableKey:@"demo-user" urlSession:[NSURLSession sharedSession]];

[api createTokenWithPayload:@"foobar" failure:^(NSError * _Nonnull error) {
    // Handle the error here
} success:^(NSDictionary<NSString *,id> * _Nonnull token) {
    // Use the token here
}];
```

## Install via CocoaPods

To install the VaultSDK via CocoaPods, put following line in your Podfile

```
pod 'VaultSDK', '~> 1.0'
```

## Run example app

Open `VaultSDK.xcworkspace` with Xcode, select target `VaultSDKExample` and a simulator then run it via CMD + R.
