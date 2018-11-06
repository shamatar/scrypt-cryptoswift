Pod::Spec.new do |s|
s.name             = "scrypt"
s.version          = "3.0"
s.summary          = "Scrypt implementation in vanilla Swift for iOS ans macOS"

s.description      = <<-DESC
Scrypt implementation in vanilla Swift, intended for use together with a Cryptoswift pod
DESC

s.homepage         = "https://github.com/shamatar/scrypt-cryptoswift"
s.license          = 'Apache License 2.0'
s.author           = { "Alex Vlasov" => "alex.m.vlasov@gmail.com" }
s.source           = { :git => 'https://github.com/shamatar/scrypt-cryptoswift.git', :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/shamatar'

s.swift_version = '4.2'
s.module_name = 'scrypt'
s.ios.deployment_target = "9.0"
s.osx.deployment_target = "10.11"
s.source_files = "scrypt/Swift/*.{swift}", "scrypt/scrypt.h"
#s.preserve_paths = "scrypt/module.modulemap"
#s.private_header_files = 'scrypt/Cimpl.h'
s.public_header_files = "scrypt/scrypt.h"
#s.module_map = "scrypt/cimpl.modulemap"
s.requires_arc = true
s.dependency 'CryptoSwift', '~> 0.13'
s.pod_target_xcconfig = {'SWIFT_WHOLE_MODULE_OPTIMIZATION' => 'YES', 
			'SWIFT_COMPILATION_MODE' => 'wholemodule',
			'SWIFT_OPTIMIZATION_LEVEL' => '-Owholemodule',
			'SWIFT_DISABLE_SAFETY_CHECKS' => 'YES',
			'SWIFT_ENFORCE_EXCLUSIVE_ACCESS' => 'compile-time',
			'GCC_UNROLL_LOOPS' => 'YES',
			'DEFINES_MODULE' => 'YES'} 

#s.xcconfig = {'SWIFT_INCLUDE_PATHS' => '$(PODS_TARGET_SRCROOT)/scrypt' }
end
