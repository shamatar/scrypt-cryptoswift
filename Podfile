def import_pods
  pod 'CryptoSwift', '~> 0.10'
end

target 'scrypt-cryptoswift' do
  platform :osx, '10.11'
#  use_frameworks!
  use_modular_headers!
  import_pods

  target 'scrypt-cryptoswiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
