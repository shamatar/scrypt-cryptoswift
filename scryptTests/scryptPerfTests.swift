//
//  scryptPerfTests.swift
//  scryptTests
//
//  Created by Alex Vlasov on 02/10/2018.
//  Copyright © 2018 Alexander Vlasov. All rights reserved.
//

import XCTest
import CryptoSwift
import scrypt

class scryptPerfTests: XCTestCase {

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

}
