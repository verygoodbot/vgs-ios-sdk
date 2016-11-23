Pod::Spec.new do |spec|
  spec.name         = 'VaultSDK'
  spec.version      = '1.0'
  spec.summary      = 'Very Good Security Vault iOS SDK for tokenizing senstive data'
  spec.homepage     = 'https://github.com/verygoodsecurity/vgs-ios-sdk'
  spec.license      = 'MIT'
  spec.license      = { type: 'MIT', file: 'LICENSE' }
  spec.author       = { 'Fang-Pen Lin' => 'hello@fangpenlin.com' }
  spec.platform     = :ios, '8.0'
  spec.source       = {
    git: 'https://github.com/verygoodsecurity/vgs-ios-sdk.git',
    tag: "v#{spec.version}"
  }
  spec.source_files = 'VaultSDK/**.swift', 'VaultSDK/**/*.swift'
end
