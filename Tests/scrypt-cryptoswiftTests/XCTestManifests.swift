import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(scrypt_cryptoswiftTests.allTests),
    ]
}
#endif