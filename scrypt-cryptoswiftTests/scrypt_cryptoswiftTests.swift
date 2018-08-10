//
//  scrypt_cryptoswiftTests.swift
//  scrypt-cryptoswiftTests
//
//  Created by Alexander Vlasov on 08.08.2018.
//  Copyright © 2018 Alexander Vlasov. All rights reserved.
//

import XCTest
import CryptoSwift

@testable import scrypt_cryptoswift

class scrypt_cryptoswiftTests: XCTestCase {
    
    func testSalsaRound() {
        var input: [UInt32] = [0x00000001, 0x00000000, 0x00000000, 0x00000000]
        Salsa.quarterround(&input)
        XCTAssert(input[0] == 0x08008145)
        XCTAssert(input[1] == 0x00000080)
        XCTAssert(input[2] == 0x00010200)
        XCTAssert(input[3] == 0x20500000)
    }
    
    func testFullSalsa() {
        let input: [UInt8] = [211,159, 13,115, 76, 55, 82,183, 3,117,222, 37,191,187,234,136,
                               49,237,179, 48, 1,106,178,219,175,199,166, 48, 86, 16,179,207,
                               31,240, 32, 63, 15, 83, 93,161,116,147, 48,113,238, 55,204, 36,
                               79,201,235, 79, 3, 81,156, 47,203, 26,244,243, 88,118,104, 54]
        var inp = input.castToUInt32LE()
        Salsa.salsa20(&inp, rounds: 20)
        let expected: [UInt8] = [109, 42,178,168,156,240,248,238,168,196,190,203, 26,110,170,154,
                                  29, 29,150, 26,150, 30,235,249,190,163,251, 48, 69,144, 51, 57,
                                  118, 40,152,157,180, 57, 27, 94,107, 42,236, 35, 27,111,114,114,
                                  219,236,232,135,111,155,110, 18, 24,232, 95,158,179, 19, 48,202]
        let exp = expected.castToUInt32LE()
        for i in 0 ..< inp.count {
            if inp[i] != exp[i] {
                print(i)
            }
            XCTAssert(inp[i] == exp[i])
        }
    }
    
    func testSalsa208DoubleRound() {
        var input: [UInt32] = [0x00000001, 0x00000000, 0x00000000, 0x00000000,
                               0x00000000, 0x00000000, 0x00000000, 0x00000000,
                               0x00000000, 0x00000000, 0x00000000, 0x00000000,
                               0x00000000, 0x00000000, 0x00000000, 0x00000000]
        Salsa.doubleround(&input)
        let expected: [UInt32] = [0x8186a22d, 0x0040a284, 0x82479210, 0x06929051,
                                  0x08000090, 0x02402200, 0x00004000, 0x00800000,
                                  0x00010200, 0x20400000, 0x08008104, 0x00000000,
                                  0x20500000, 0xa0000040, 0x0008180a, 0x612a8020]
        for i in 0 ..< input.count {
            if input[i] != expected[i] {
                print(i)
            }
            XCTAssert(input[i] == expected[i])
        }
    }
    
    func testLEconversion() {
        let bytes : Array<UInt8> = [86, 75, 30, 9]
        let cast = bytes.castToUInt32LE()
        print(String(cast[0], radix: 16))
        XCTAssert(cast[0] == 0x091e4b56)
    }
    
    func testSalsa208_RFC() {
        var input: [UInt8] = Array<UInt8>.init(hex: """
            7e 87 9a 21 4f 3e c9 86 7c a9 40 e6 41 71 8f 26
            ba ee 55 5b 8c 61 c1 b5 0d f8 46 11 6d cd 3b 1d
            ee 24 f3 19 df 9b 3d 85 14 12 1e 4b 5a c5 aa 32
            76 02 1d 29 09 c7 48 29 ed eb c6 8d b8 b8 c2 5e
""".replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: ""))
        Salsa.salsa20(&input, rounds: 8)
        let expected: [UInt8] = Array<UInt8>.init(hex: """
            a4 1f 85 9c 66 08 cc 99 3b 81 ca cb 02 0c ef 05
           04 4b 21 81 a2 fd 33 7d fd 7b 1c 63 96 68 2f 29
           b4 39 31 68 e3 c9 e6 bc fe 6b c5 b7 a0 6d 96 ba
           e4 24 cc 10 2c 91 74 5c 24 ad 67 3d c7 61 8f 81
""".replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: ""))
        for i in 0 ..< input.count {
            XCTAssert(input[i] == expected[i])
        }
        
        
    }
    
    func testSmix() {
        let input: [UInt8] = Array<UInt8>.init(hex: """
        f7 ce 0b 65 3d 2d 72 a4 10 8c f5 ab e9 12 ff dd
       77 76 16 db bb 27 a7 0e 82 04 f3 ae 2d 0f 6f ad
       89 f6 8f 48 11 d1 e8 7b cc 3b d7 40 0a 9f fd 29
       09 4f 01 84 63 95 74 f3 9a e5 a1 31 52 17 bc d7
       89 49 91 44 72 13 bb 22 6c 25 b5 4d a8 63 70 fb
       cd 98 43 80 37 46 66 bb 8f fc b5 bf 40 c2 54 b0
       67 d2 7c 51 ce 4a d5 fe d8 29 c9 0b 50 5a 57 1b
       7f 4d 1c ad 6a 52 3c da 77 0e 67 bc ea af 7e 89
""".replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: ""))
        let N = 16
        let r = 1
        var v = Array<UInt32>(repeating: 0, count: 32*N*r)
        var xy = Array<UInt32>(repeating: 0, count: 64*r)
        var slice = ArraySlice<UInt8>(input)
        CryptoSwift.PKCS5.Scrypt.smix(b: &slice, N: N, r: r, v: &v, xy: &xy)
        let expected: [UInt8] = Array<UInt8>.init(hex: """
        79 cc c1 93 62 9d eb ca 04 7f 0b 70 60 4b f6 b6
       2c e3 dd 4a 96 26 e3 55 fa fc 61 98 e6 ea 2b 46
       d5 84 13 67 3b 99 b0 29 d6 65 c3 57 60 1f b4 26
       a0 b2 f4 bb a2 00 ee 9f 0a 43 d1 9b 57 1a 9c 71
       ef 11 42 e6 5d 5a 26 6f dd ca 83 2c e5 9f aa 7c
       ac 0b 9c f1 be 2b ff ca 30 0d 01 ee 38 76 19 c4
       ae 12 fd 44 38 f2 03 a0 e4 e1 c4 7e c3 14 86 1f
       4e 90 87 cb 33 39 6a 68 73 e8 f9 d2 53 9a 4b 8e
""".replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "\t", with: ""))
        for i in 0 ..< expected.count {
            XCTAssert(slice[i] == expected[i])
        }
    }
    
    func testScrypt() {
        do {
            let password = Array("password".data(using: .ascii)!)
            let salt = Array("NaCl".data(using: .ascii)!)
            let deriver = try CryptoSwift.PKCS5.Scrypt.init(password: password, salt: salt, dkLen: 64, N: 1024, r: 8, p: 16)
            let derived = try deriver.calculate()
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
    
    func testIngetrify() {
        let data: Array<UInt8> = [0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00]
        let x = CryptoSwift.PKCS5.Scrypt.integerify(data)
        XCTAssert(x == 1 + (1<<48))
    }
    
    func testScryptPerformance() {
        let password = Array("password".data(using: .ascii)!)
        let salt = Array("NaCl".data(using: .ascii)!)
        let deriver = try! CryptoSwift.PKCS5.Scrypt.init(password: password, salt: salt, dkLen: 64, N: 1024, r: 8, p: 16)
        measure {
            let _ = try! deriver.calculate()
        }
    }
}
