//
//  UILabelExtension.swift
//  PinyinLabelExtension
//
//  Created by Lost In Ireland on 07/01/2019.
//

import UIKit

@IBDesignable
class PinyinLabel : UILabel {
    var pinyin: String = "";
    var letter: String = "";
    
    override func drawText(in rect: CGRect) {
        if text != nil {
            pinyin = text!;
            if let rangeOfV = pinyin.range(of: "v") {
                pinyin.replaceSubrange(rangeOfV, with: "ü");
            }
            letter = String(text![0 ..< pinyin.count - 1]);
            if let rangeOfV = letter.range(of: "v") {
                letter.replaceSubrange(rangeOfV, with: "ü");
            }
        }
        if !pinyin.isEmpty {
            var y: CGFloat = 0;
            let toneNumber = pinyin.last;
            let tone = getTone(toneNumber: toneNumber);
            let stateIndex = getStateIndex(text: pinyin);
            if stateIndex != -1 {
                // If tone is not above 'ü'
                if pinyin[stateIndex] != "ü" {
                    y += tone.size(OfFont: font).height / 8;
                }
                
                // If tone is above 'i', replace 'i' by 'ı'
                if pinyin[stateIndex] == "i" {
                    if let rangeOfI = pinyin.range(of: "i") {
                        letter.replaceSubrange(rangeOfI, with: "ı");
                    }
                }
            }
            let nsTone = NSString(string: tone);
            let attributes = attributedText?.attributes(at: 0, effectiveRange: nil);
            
            // FIXME: if the label text is not align left, it break
            let x = rect.origin.x
                + pinyin[0 ..< stateIndex].size(OfFont: font).width
                + (pinyin[stateIndex].size(OfFont: font).width - tone.size(OfFont: font).width ) / 2;
            nsTone.draw(at: CGPoint(x: x, y: y), withAttributes: attributes);
        }
        text = letter;
        super.drawText(in: rect);
    }
    
    func getTone(toneNumber: Character?) -> String {
        if let toneValue = toneNumber {
            switch toneValue {
            case "1":
                return "ˉ"
            case "2":
                return "ˊ"
            case "3":
                return "ˇ"
            case "4":
                return "ˋ"
            default:
                return ""
            }
        }
        return "";
    }
    
    func getStateIndex(text: String) -> Int {
        var toneIndex = text.count - 1;
        var stateIndex = -1;
        while toneIndex >= 0 {
            let letter = text[toneIndex ..< toneIndex + 1];
            if letter == "a"
                || letter == "e"
                || letter == "i"
                || letter == "o"
                || letter == "u"
                || letter == "ü" {
                if stateIndex == -1 || text[toneIndex] < text[stateIndex] {
                    stateIndex = toneIndex;
                }
            }
            toneIndex = toneIndex - 1;
        }
        
        // if 'iu' in pinyin
        if text.contains("u")
            && text.contains("i")
            && !text.contains("a")
            && !text.contains("o")
            && !text.contains("e") {
            
            let indexOfU = text.index(of: "u")?.encodedOffset;
            let indexOfI = text.index(of: "i")?.encodedOffset;
            if let indexOfUInt = indexOfU, let indexOfInt = indexOfI {
                if indexOfUInt > indexOfInt {
                    stateIndex = indexOfUInt;
                } else {
                    stateIndex = indexOfInt;
                }
            }
        }
        return stateIndex
    }
}


extension String {
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedStringKey.font: font])
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}
extension Substring {
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedStringKey.font: font])
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}

extension Character {
    func size(OfFont font: UIFont) -> CGSize {
        return (String(self) as NSString).size(withAttributes: [NSAttributedStringKey.font: font])
    }
}
