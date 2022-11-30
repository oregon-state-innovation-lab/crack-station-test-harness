//
//  TestTheTest.swift
//  
//
//  Created by Will on 11/24/22.
//

import XCTest

final class TestTheTest: XCTestCase {
    /// Make sure the testing assumptions are valid.
    func testTheTest() {
        let totalHashes = LookupTable.shared.totalHashes
        XCTAssertEqual(totalHashes, LookupTable.shared.sha1s.count + LookupTable.shared.sha2s.count)

        let totalPasswords =
        LookupTable.shared.justPasswords_1letter.count +
        LookupTable.shared.justPasswords_2letter.count +
        LookupTable.shared.justPasswords_3letter.count
        XCTAssertEqual(totalHashes / 2, totalPasswords)
    }
}
