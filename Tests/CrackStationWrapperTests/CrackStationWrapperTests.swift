//
// SI Lab, 2022
//

import CrackStationWrapper
import CryptoKit
import XCTest

final class CrackStationTests: XCTestCase {
    private let crackStation = CrackStationWrapper()

    // MARK: - Happy path

    //tests for POC v1
    func testAllOneLetterSha1Permutations() throws {
        for letter in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" {
            // Given
            let password = String(letter)
            let shaHash = encrypt(password)

            // When
            let crackedPassword = crackStation.decrypt(shaHash: shaHash)

            // Then
            XCTAssertEqual(crackedPassword, password)
        }
    }

    
    // tests for POC v2
    func testTwoLetterSha1_aa() throws {
        // Given
        let password = "aa"
        let shaHash = encrypt(password)

        // When
        let crackedPassword = crackStation.decrypt(shaHash: shaHash)

        // Then
        XCTAssertEqual(crackedPassword, password)
    }

    func testTwoLetterSha1_99() throws {
        // Given
        let password = "99"
        let shaHash = encrypt(password)

        // When
        let crackedPassword = crackStation.decrypt(shaHash: shaHash)

        // Then
        XCTAssertEqual(crackedPassword, password)
    }

    func testTwoLetterSha1_otherCases() throws {
        // TODO: Write
    }

    // MARK: - Edge cases / rainy day scenarios

    func testEmptyString() throws {
        // Given
        let password = ""
        let shaHash = encrypt(password)

        // When
        let crackedPassword = crackStation.decrypt(shaHash: shaHash)

        // Then
        XCTAssertEqual(crackedPassword, nil)
    }

    func testInvalidShaHash() throws {
        // TODO: Write
    }

    // MARK: - Helpers
    
    
    // tests for MVP
    
    func testGivenCrackApiWithSha1_WhenAllCharacterCombinationsAreGiven_ThenShouldDecrypt() {
        DispatchQueue.concurrentPerform(iterations: arrayOfCombinations.count) {
            password in
            let expectedPassword = arrayOfCombinations[password]
            let passwordEncryption = encrypt(expectedPassword)
            let actualPassword = crackstation.decrypt(shaHash: passwordEncryption)
            XCTAssertEqual(actualPassword, expectedPassword)
        }
    }
    
    func testGivenCrackApiWithSha256_WhenAllCharacterCombinationsAreGiven_ThenShouldDecrypt() {
        DispatchQueue.concurrentPerform(iterations: arrayOfCombinations.count) {
            password in
            let expectedPassword = arrayOfCombinations[password]
            let passwordEncryption = encryptSha256(expectedPassword)
            let actualPassword = crackstation.decrypt(shaHash: passwordEncryption)
            XCTAssertEqual(expectedPassword, actualPassword)
        }
    }
    
    lazy var arrayOfCombinations = getAllCombinations()

    private func encrypt(_ password: String) -> String {
        let dataToHash = Data(password.utf8)
        let prefix = "SHA 1 digest: "
        let shaHashDescription = String(Insecure.SHA1.hash(data: dataToHash).description)
        let shaHash = String(shaHashDescription.dropFirst(prefix.count - 1))
        return shaHash
    }
    
    private func encryptSha256(_ password: String) -> String {
        let dataToHash = Data(password.utf8)
        let prefix = "SHA256 digest: "
        let shaHashDescription = String(SHA256.hash(data: dataToHash).description)
        let shaHash = String(shaHashDescription.dropFirst(prefix.count - 1))
        return shaHash
    }
    
    private func getAllCombinations() -> [String] {
        var combinationArray = [String]()
        let string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!?"
    
        for char in string {
            combinationArray.append(String(char))
            for secondChar in string {
                combinationArray.append(String(char) + String(secondChar))
                for thirdChar in string {
                    combinationArray.append(String(char) + String(secondChar) + String(thirdChar))
                }
            }
        }
        return combinationArray
    }
}

