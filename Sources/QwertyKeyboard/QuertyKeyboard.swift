import Cocoa
import CoreGraphics

public final class QuertyKeyboard {
    private let sourceStateID: CGEventSourceStateID

    public init(sourceStateID: CGEventSourceStateID = .combinedSessionState) {
        self.sourceStateID = sourceStateID
    }

    public func type(string: String) {
        string.keys().forEach {
            if let modifier = $0.modifier {
                press(key: $0.Key, withModifiers: [modifier])
            } else {
                press(key: $0.Key)
            }
        }
    }

    public func press(key: Key, withModifiers modifierKeys: [ModifierKey] = []) {
        sendPressEvent(.init(bitPattern: key.rawValue), flags: modifierKeys.flags)
    }

    private func sendPressEvent(_ key: CGKeyCode, flags: CGEventFlags) {
        guard let source = CGEventSource(stateID: sourceStateID),
              let keyDown = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: true),
              let keyUp = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: false) else {
            return
        }

        keyDown.flags = flags
        keyDown.post(tap: .cghidEventTap)
        keyUp.post(tap: .cghidEventTap)
    }
}

private extension Collection where Element == ModifierKey {
    var flags: CGEventFlags {
        reduce(CGEventFlags()) { $0.union($1.flag) }
    }
}

private extension String {
    func keys() -> [(Key: Key, modifier: ModifierKey?)] {
        return compactMap { $0.KeyAndModifier() }
    }
}

private extension Character {
    func KeyAndModifier() -> (Key, ModifierKey?)? {
        if let key = Character.keyMapping[self] {
            return (key, nil)
        } else if let key = Character.shiftKeyMapping[self]  {
            return (key, .shift)
        }
        return nil
    }

    private static let keyMapping: [Character: Key] = [
        "a": .a,
        "b": .b,
        "c": .c,
        "d": .d,
        "e": .e,
        "f": .f,
        "g": .g,
        "h": .h,
        "i": .i,
        "j": .j,
        "k": .k,
        "l": .l,
        "m": .m,
        "n": .n,
        "o": .o,
        "p": .p,
        "q": .q,
        "r": .r,
        "s": .s,
        "t": .t,
        "u": .u,
        "v": .v,
        "w": .w,
        "x": .x,
        "y": .y,
        "z": .z,
        "1": .number1,
        "2": .number2,
        "3": .number3,
        "4": .number4,
        "5": .number5,
        "6": .number6,
        "7": .number7,
        "8": .number8,
        "9": .number9,
        "0": .number0,
        "=": .equal,
        "-": .minus,
        "[": .leftBracket,
        "]": .rightBracket,
        "'": .quote,
        ";": .semiColon,
        "\\": .backSlash,
        ",": .comma,
        "/": .forwardSlash,
        ".": .fullStop,
        "`": .backtick,
        "\t": .tab,
        " ": .space
    ]

    private static let shiftKeyMapping: [Character: Key] = [
        "A": .a,
        "B": .b,
        "C": .c,
        "D": .d,
        "E": .e,
        "F": .f,
        "G": .g,
        "H": .h,
        "I": .i,
        "J": .j,
        "K": .k,
        "L": .l,
        "M": .m,
        "N": .n,
        "O": .o,
        "P": .p,
        "Q": .q,
        "R": .r,
        "S": .s,
        "T": .t,
        "U": .u,
        "V": .v,
        "W": .w,
        "X": .x,
        "Y": .y,
        "Z": .z,
        "!": .number1,
        "@": .number2,
        "#": .number3,
        "$": .number4,
        "%": .number5,
        "^": .number6,
        "&": .number7,
        "*": .number8,
        "(": .number9,
        ")": .number0,
        "+": .equal,
        "_": .minus,
        "{": .leftBracket,
        "}": .rightBracket,
        "\"": .quote,
        ":": .semiColon,
        "|": .backSlash,
        "<": .comma,
        "?": .forwardSlash,
        ">": .fullStop,
        "~": .backtick,
    ]
}
