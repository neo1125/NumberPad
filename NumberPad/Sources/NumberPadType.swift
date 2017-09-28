import Foundation

public enum NumberPadStyle {
    case square
    case circle
}

public enum NumberKey: Int {
    case key0 = 0, key1 = 1, key2, key3, key4, key5, key6, key7, key8, key9
    case custom = 99, clear = -1, empty = -2
    
    func value() -> String? {
        if self.rawValue >= 0 && self.rawValue <= 9 {
            return "\(self.rawValue)"
        } else if self.rawValue == 99 {
            return nil
        } else {
            return nil
        }
    }
}

public enum NumberClearKeyPosition {
    case left, right
}


