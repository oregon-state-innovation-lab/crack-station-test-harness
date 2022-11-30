//
//  MPV_SHA-256_Tests.swift
//  
//
//  Created by Will on 11/24/22.
//

import XCTest
import CrackStation
import CrackStationWrapper

final class MPV_SHA_256_Tests: XCTestCase {
    private let crackStation = CrackStationWrapper()

    // MARK: - Happy path for SHA-256
    
    func test_sha256_1letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_1letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_1letter[i]
            let sha256 = try! XCTUnwrap(LookupTable.shared.sha2s[expectedPassword])
            
            // When
            let actualPassword = crackStation.decrypt(shaHash: sha256)
            
            // Then
            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }
    
    func test_sha256_2letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_2letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_2letter[i]
            let sha256 = try! XCTUnwrap(LookupTable.shared.sha2s[expectedPassword])
            
            // When
            let actualPassword = crackStation.decrypt(shaHash: sha256)
            
            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }
    
    func test_sha256_3letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_2letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_2letter[i]
            let sha256 = try! XCTUnwrap(LookupTable.shared.sha2s[expectedPassword])
            
            // When
            let actualPassword = crackStation.decrypt(shaHash: sha256)
            
            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }
}
