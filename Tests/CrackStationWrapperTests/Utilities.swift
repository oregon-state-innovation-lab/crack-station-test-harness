import Foundation
import CryptoKit

// The global constant to switch from POC to MVP character set
let alphabet = PRD.mvp.alphabet

// MARK: - Helpers

private enum PRD {
    case poc, mvp

    private static let baseAlphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    var alphabet: String {
        switch self {
        case .poc: return Self.baseAlphabet
        case .mvp: return "\(Self.baseAlphabet)?!"
        }
    }
}

class LookupTable {
    // MARK: - API

    static let shared = LookupTable()

    var totalHashes: Int {
        Self.passwords.count
    }

    func decrypt(sha: String) -> String? {
        return Self.passwords[sha]
    }

    private(set) static var sha1s: [String: String] = [:]
    private(set) static var sha2s: [String: String] = [:]
    private(set) static var justPasswords: [String] = []

    // MARK: - Private implementation

    private static var passwords: [String: String] = [:]

    private init() {
        addOneLetterPasswords()
        addTwoLetterPasswords()
        addThreeLetterPasswords()
    }

    private func encryptAndAdd(_ password: String) {
        Self.justPasswords.append(password)

        let sha1 = sha1(password)
        let sha2 = sha256(password)

        Self.passwords[sha1] = password
        Self.passwords[sha2] = password

        Self.sha1s[password] = sha1
        Self.sha2s[password] = sha2
    }

    private func addOneLetterPasswords() {
        for letter in alphabet {
            let password = String(letter)
            encryptAndAdd(password)
        }
    }

    private func addTwoLetterPasswords() {
        for a in alphabet {
            for b in alphabet {
                let password = String("\(a)\(b)")
                encryptAndAdd(password)
            }
        }
    }

    private func addThreeLetterPasswords() {
        for a in alphabet {
            for b in alphabet {
                for c in alphabet {
                    let password = String("\(a)\(b)\(c)")
                    encryptAndAdd(password)
                }
            }
        }
    }
}

private func sha1(_ password: String) -> String {
    let dataToHash = Data(password.utf8)
    let prefix = "SHA1 digest: "
    let shaHashDescription = String(Insecure.SHA1.hash(data: dataToHash).description)
    let shaHash = String(shaHashDescription.dropFirst(prefix.count))
    return shaHash
}

private func sha256(_ password: String) -> String {
    let dataToHash = Data(password.utf8)
    let prefix = "SHA256 digest: "
    let shaHashDescription = String(SHA256.hash(data: dataToHash).description)
    let shaHash = String(shaHashDescription.dropFirst(prefix.count))
    return shaHash
}
