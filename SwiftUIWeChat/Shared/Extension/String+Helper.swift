//
//  String+Helper.swift
//  SwiftUIWeChat
//
//  Created by peak on 2022/3/23.
//

import Foundation

extension String {
    
    /// Convert `2022-02-21 12:24:45` to Date
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self) ?? .init()
    }
}
