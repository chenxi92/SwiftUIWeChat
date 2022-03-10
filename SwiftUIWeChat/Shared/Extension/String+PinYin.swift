//
//  String+PinYin.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/10.
//

import Foundation

extension String {
    func isContainChinese() -> Bool {
        for ch in self.unicodeScalars {
            if 0x4e00 < ch.value && ch.value < 0x9fff {
                return true
            }
        }
        return false
    }
    
    func transformToPinYin() -> String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        return String(mutableString).replacingOccurrences(of: " ", with: "")
    }
    
    func firstString() -> String {
        if self.isContainChinese() {
            let pinYin = self.transformToPinYin()
            if pinYin.isEmpty {
                return ""
            } else {
                return String(pinYin.first!).uppercased()
            }
        }
        if self.isEmpty {
            return ""
        }
        return String(self.first!).uppercased()
    }
}
