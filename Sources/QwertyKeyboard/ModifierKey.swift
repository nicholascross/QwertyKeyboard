import Cocoa
import CoreGraphics

public enum ModifierKey {
    case shift
    case control
    case alt
    case command
    case function

    var flag: CGEventFlags {
        switch self {
        case .shift:
            return .maskShift
        case .control:
            return .maskControl
        case .alt:
            return .maskAlternate
        case .command:
            return .maskCommand
        case .function:
            return .maskSecondaryFn
        }
    }
}
