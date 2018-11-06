//
//  Scrypt.swift
//  scrypt-cryptoswift
//
//  Created by Alexander Vlasov on 08.08.2018.
//  Copyright © 2018 Alexander Vlasov. All rights reserved.
//

//  https://www.ietf.org/rfc/rfc7914.txt
//
import CryptoSwift
import Foundation

//import scryptC

/// A key derivation function.
///
/// Scrypt - Password-Based Key Derivation Function. Key stretching technique.
//    Passphrase:                Bytes    string of characters to be hashed
//    Salt:                      Bytes    random salt
//    CostFactor (N):            Integer  CPU/memory cost parameter
//    BlockSizeFactor (r):       Integer  blocksize parameter (8 is commonly used)
//    ParallelizationFactor (p): Integer  Parallelization parameter. (1..232-1 * hLen/MFlen)
//    DesiredKeyLen:

public struct Scrypt {
    public enum Error: Swift.Error {
        case invalidInput
        case derivedKeyTooLong
        case pValueTooLarge
        case nValueNotPowerOf2
    }
    
    private let salt: Array<UInt8> // S
    private let password: Array<UInt8>
    fileprivate let blocksize: Int // 128 * r
    private let dkLen: Int
    private let N: Int
    private let r: Int
    private let p: Int

    public init(password: Array<UInt8>, salt: Array<UInt8>, dkLen: Int, N: Int, r: Int, p: Int) throws {
        precondition(dkLen > 0)
        precondition(N > 0)
        precondition(r > 0)
        precondition(p > 0)
        
        let MFLen = Double(r)*128
        let hLen = Double(32)
        
        if N & (N-1) != 0 {
            throw Error.nValueNotPowerOf2
        }
        
        if Double(p) > (pow(2, 32) - 1) * hLen / MFLen {
            throw Error.pValueTooLarge
        }
        
        if Double(dkLen) > (pow(2, 32) - 1) * hLen {
            throw Error.derivedKeyTooLong
        }
        
        self.blocksize = 128 * r
        self.N = N
        self.r = r
        self.p = p
        self.password = password
        self.salt = salt
        self.dkLen = dkLen
    }
    
    public func calculate() throws -> Array<UInt8> {
        return try calculateNatively()
//        return try calculateUsingC()
    }
    
    public func calculateNatively() throws -> Array<UInt8> {
        let paDeriver = try ScryptPA.init(password: self.password, salt: self.salt, dkLen: self.dkLen, N: self.N, r: self.r, p: self.p)
        return try paDeriver.calculate()
    }
    
//    public func calculateUsingC() throws -> Array<UInt8> {
//        var kdf = try CryptoSwift.PKCS5.PBKDF2(password: password, salt: salt, iterations: 1, keyLength: blocksize*p, variant: .sha256)
//        var B = try kdf.calculate()
//
//        let extraMemoryLength = 128 * r * N + 256 * r + 64
//        var extraMemory = [UInt8](repeating: 0, count: extraMemoryLength)
//
//        let res = partial_Scrypt(UInt64(N), UInt32(r), UInt32(p), &B, B.count, &extraMemory, extraMemoryLength)
//        if res != 0 {
//            throw Error.derivedKeyTooLong
//        }
//        kdf = try CryptoSwift.PKCS5.PBKDF2(password: self.password, salt: B, iterations: 1, keyLength: dkLen, variant: .sha256)
//        let ret = try kdf.calculate()
//        return Array(ret)
//    }
    
}
