//
// SI Lab, 2022
//

import CrackStationWrapper
import CryptoKit
import XCTest

final class MVP_Tests: XCTestCase {
    private let crackStation = CrackStationWrapper()

    // MARK: - Happy path

    func testEverything() throws {
        // Make sure the testing assumptions are valid
        let totalHashes = LookupTable.shared.totalHashes
        XCTAssertEqual(totalHashes, LookupTable.sha1s.count + LookupTable.sha2s.count)

        let totalPasswords = LookupTable.justPasswords.count
        XCTAssertEqual(totalHashes / 2, totalPasswords)

        // Now we are ready to test
        DispatchQueue.concurrentPerform(iterations: totalPasswords) { i in
            // Given
            let expectedPassword = LookupTable.justPasswords[i]
            let sha1 = try! XCTUnwrap(LookupTable.sha1s[expectedPassword])
            let sha256 = try! XCTUnwrap(LookupTable.sha2s[expectedPassword])

            // When
            let sha1Password = crackStation.decrypt(shaHash: sha1)
            let sha256Password = crackStation.decrypt(shaHash: sha256)

            // Then
            XCTAssertEqual(expectedPassword, sha1Password)
            XCTAssertEqual(expectedPassword, sha256Password)
        }
    }

    // MARK: - Edge cases

    func testEmptyStringForShaHash() {
        let password = crackStation.decrypt(shaHash: "")
        XCTAssertNil(password)
    }
}

