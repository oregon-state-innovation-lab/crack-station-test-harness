import Foundation

// The global constant to switch from POC to MVP character set
let alphabet = PRD.mvp.alphabet

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
