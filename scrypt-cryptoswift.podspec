Pod::Spec.new do |s|
s.name             = "scrypt-cryptoswift"
s.version          = "1.1"
s.summary          = "Scrypt implementation in vanilla Swift for iOS ans macOS"

s.description      = <<-DESC
Scrypt implementation in vanilla Swift, intended for use together with a Cryptoswift pod
DESC

s.homepage         = "https://github.com/shamatar/scrypt-cryptoswift"
s.license          = 'Apache License 2.0'
s.author           = { "Alex Vlasov" => "alex.m.vlasov@gmail.com" }
s.source           = { :git => 'https://github.com/shamatar/scrypt-cryptoswift.git', :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/shamatar'

s.swift_version = '4.1'
s.module_name = 'scrypt_cryptoswift'
s.ios.deployment_target = "9.0"
s.osx.deployment_target = "10.11"
s.source_files = "scrypt-cryptoswift/**/*.{swift}",
s.public_header_files = "scrypt-cryptoswift/scrypt_cryptoswift.h"
s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }

s.dependency 'CryptoSwift', '~> 0.11'
end
