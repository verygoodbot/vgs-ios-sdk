# vgs-ios-sdk
Very Good Security iOS SDK

## Usage

```Swift
import VaultSDK

let api = VaultAPI(
    baseURL: URL(string: "https://demo.sandbox.verygoodvault.com")!,
    publishableKey: "demo-user"
)
try! api.createToken(
    payload: "4111111111111111",
    failure: { error in
        // Deal with the error
    },
    success: { token in
        // Use the token here
    }
)
 ```

## Install via CocoaPods

To install the VaultSDK via CocoaPods, put following line in your Podfile

```
pod 'VaultSDK', '~> 1.0'
```
