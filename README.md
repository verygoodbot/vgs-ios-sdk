# Vault iOS SDK 

[![CircleCI](https://circleci.com/gh/verygoodsecurity/vgs-ios-sdk.svg?style=svg)](https://circleci.com/gh/verygoodsecurity/vgs-ios-sdk)

Objective-C SDK for consuming vault api. 

Usage
-----

```objective-c
#import "VaultSDK.h"
```

#### configure

```objective-c
[[VaultSDK sharedInstance] setPublishableKey:@"vault_live_AbCdEfGhIjKLMnOpqrS"];
```

#### Create token

```objective-c

    NSDictionary *params = @{@"raw": ![self.creditCardNumberTextField.text isEqualToString:@""] ? self.creditCardNumberTextField.text : @"4111111111111111" };
    
    [[VaultSDK sharedInstance] createTokenWithCreditCardNumber:params withSucess:^(NSDictionary * _Nonnull item) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showSuccess];
        });
    } failure:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showError];
        });
    }];

```

Documentation
-------------

[Apple Docs](http://williamlocke.github.io/vault-ios-sdk/logs/appledoc/html/Classes/VaultSDK.html)


Credits
-------

Thanks to [williamlocke](https://github.com/williamlocke) for the initial contribution!
