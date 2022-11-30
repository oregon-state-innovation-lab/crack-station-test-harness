//
// SI Lab, 2022
//

import CrackStationWrapper
import CryptoKit
import XCTest

final class MVP_SHA_1_Tests: XCTestCase {
    private let crackStation = CrackStationWrapper()

    // MARK: - Happy path for SHA-1

    func test_sha1_1letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_1letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_1letter[i]
            let sha1 = try! XCTUnwrap(LookupTable.shared.sha1s[expectedPassword])

            // When
            let actualPassword = crackStation.decrypt(shaHash: sha1)

            // Then
            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }

    func test_sha1_2letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_2letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_2letter[i]
            let sha1 = try! XCTUnwrap(LookupTable.shared.sha1s[expectedPassword])

            // When
            let actualPassword = crackStation.decrypt(shaHash: sha1)

            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }

    func test_sha1_3letter() throws {
        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: LookupTable.shared.justPasswords_2letter.count) { i in
            // Given
            let expectedPassword = LookupTable.shared.justPasswords_2letter[i]
            let sha1 = try! XCTUnwrap(LookupTable.shared.sha1s[expectedPassword])

            // When
            let actualPassword = crackStation.decrypt(shaHash: sha1)

            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }
}
