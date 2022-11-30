import Foundation
import CryptoKit

class LookupTable {
    // MARK: - API

    static let shared = LookupTable()

    var totalHashes: Int {
        passwords.count
    }

    func decrypt(sha: String) -> String? {
        return passwords[sha]
    }

    private(set) var sha1s: [String: String] = [:]
    private(set) var sha2s: [String: String] = [:]

    private(set) var justPasswords_1letter: [String] = []
    private(set) var justPasswords_2letter: [String] = []
    private(set) var justPasswords_3letter: [String] = []

    // MARK: - Private implementation

    private var passwords: [String: String] = [:]

    private init() {
        addPasswords_1letter()
        addPasswords_2letter()
        addPasswords_3letter()
    }

    private func encryptAndAdd_1letter(_ password: String) {
        justPasswords_1letter.append(password)

        let sha1 = sha1(password)
        let sha2 = sha256(password)

        passwords[sha1] = password
        passwords[sha2] = password

        sha1s[password] = sha1
        sha2s[password] = sha2
    }

    private func encryptAndAdd_2letter(_ password: String) {
        justPasswords_2letter.append(password)

        let sha1 = sha1(password)
        let sha2 = sha256(password)

        passwords[sha1] = password
        passwords[sha2] = password

        sha1s[password] = sha1
        sha2s[password] = sha2
    }

    private func encryptAndAdd_3letter(_ password: String) {
        justPasswords_3letter.append(password)

        let sha1 = sha1(password)
        let sha2 = sha256(password)

        passwords[sha1] = password
        passwords[sha2] = password

        sha1s[password] = sha1
        sha2s[password] = sha2
    }

    private func addPasswords_1letter() {
        for letter in alphabet {
            let password = String(letter)
            encryptAndAdd_1letter(password)
        }
    }

    private func addPasswords_2letter() {
        for a in alphabet {
            for b in alphabet {
                let password = String("\(a)\(b)")
                encryptAndAdd_2letter(password)
            }
        }
    }

    private func addPasswords_3letter() {
        for a in alphabet {
            for b in alphabet {
                for c in alphabet {
                    let password = String("\(a)\(b)\(c)")
                    encryptAndAdd_3letter(password)
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

