//
//  scrypt_cryptoswiftTests.swift
//  scrypt-cryptoswiftTests
//
//  Created by Alexander Vlasov on 08.08.2018.
//  Copyright © 2018 Alexander Vlasov. All rights reserved.
//

import XCTest
import CryptoSwift

@testable import scrypt

class scryptTests: XCTestCase {
    
    func testScrypt() {
        do {
            let password = Array("password".data(using: .ascii)!)
            let salt = Array("NaCl".data(using: .ascii)!)
            let deriver = try Scrypt.init(password: password, salt: salt, dkLen: 64, N: 1024, r: 8, p: 16)
            let derived = try deriver.calculateNatively()
            let expected: [UInt8] = Array<UInt8>.init(hex: """
                fd ba be 1c 9d 34 72 00 78 56 e7 19 0d 01 e9 fe
                   7c 6a d7 cb c8 23 78 30 e7 73 76 63 4b 37 31 62
                   2e af 30 d9 2e 22 a3 88 6f f1 09 27 9d 98 30 da
                   c7 27 af b9 4a 83 ee 6d 83 60 cb df a2 cc 06 40
    """.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: ""))
            for i in 0 ..< expected.count {
                XCTAssert(derived[i] == expected[i])
            }
        }
        catch {
            print(error)
            XCTFail()
        }
    }

//    func testScryptC() {
//        do {
//            let password = Array("password".data(using: .ascii)!)
//            let salt = Array("NaCl".data(using: .ascii)!)
//            let deriver = try Scrypt.init(password: password, salt: salt, dkLen: 64, N: 1024, r: 8, p: 16)
//            let derived = try deriver.calculateUsingC()
//            let expected: [UInt8] = Array<UInt8>.init(hex: """
//                fd ba be 1c 9d 34 72 00 78 56 e7 19 0d 01 e9 fe
//                   7c 6a d7 cb c8 23 78 30 e7 73 76 63 4b 37 31 62
//                   2e af 30 d9 2e 22 a3 88 6f f1 09 27 9d 98 30 da
//                   c7 27 af b9 4a 83 ee 6d 83 60 cb df a2 cc 06 40
//    """.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: ""))
//            for i in 0 ..< expected.count {
//                XCTAssert(derived[i] == expected[i])
//            }
//        }
//        catch {
//            print(error)
//            XCTFail()
//        }
//    }
    
    func testScryptPerformance() {
        let password = "TEST"
        let salt = Array("SALT".data(using: .ascii)!)
        let deriver = try! Scrypt(password: Array(password.data(using: .ascii)!), salt: salt, dkLen: 32, N: 4096, r: 6, p: 1)
        measure {
            let _ = try! deriver.calculateNatively()
        }
    }
    
//    func testScryptPerformanceInC() {
//        let password = "TEST"
//        let salt = Array("SALT".data(using: .ascii)!)
//        let deriver = try! Scrypt(password: Array(password.data(using: .ascii)!), salt: salt, dkLen: 32, N: 4096, r: 6, p: 1)
//        measure {
//            let _ = try! deriver.calculateUsingC()
//        }
//    }
    
    func testScryptPerformancePointerArithmetics() {
        let password = "TEST"
        let salt = Array("SALT".data(using: .ascii)!)
        let deriver = try! ScryptPA(password: Array(password.data(using: .ascii)!), salt: salt, dkLen: 32, N: 4096, r: 6, p: 1)
        measure {
            let _ = try! deriver.calculate()
        }
    }
    
    func testProfilerRun() {
        //            N: Int = 4096, R: Int = 6, P: Int = 1
        let password = "TEST"
        let salt = Array("SALT".data(using: .ascii)!)
        let deriver = try! Scrypt(password: Array(password.data(using: .ascii)!), salt: salt, dkLen: 32, N: 4096, r: 6, p: 1)
        let _ = try! deriver.calculate()
    }
    
    func testProfilerRunPA() {
        //            N: Int = 4096, R: Int = 6, P: Int = 1
        let password = "TEST"
        let salt = Array("SALT".data(using: .ascii)!)
        let deriver = try! ScryptPA(password: Array(password.data(using: .ascii)!), salt: salt, dkLen: 32, N: 4096, r: 6, p: 1)
        let _ = try! deriver.calculate()
    }
    
    
}
