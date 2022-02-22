//
//  Date-Helper.swift
//  SwiftUIWeChat
//
//  Created by 陈希 on 2022/2/18.
//

import Foundation

extension Date {
    
    func asChatString() -> String {
        
        let calendar = Calendar.current
        let selfComp = calendar.dateComponents([.year, .month, .weekday, .day], from: self)
        let nowComp = calendar.dateComponents([.year, .month, .weekday, .day], from: Date())
        
        let formatter = DateFormatter()
        if nowComp.year != selfComp.year {
            // other year
            formatter.dateFormat = "yyyy年M月d日"
            return formatter.string(from: self)
        }
        
        if nowComp.month == selfComp.month {
            if nowComp.weekday != selfComp.weekday {
                // same year, same month, other week
               return asWeekday()
            } else {
                // same year, same month, same week
                
                if nowComp.day == selfComp.day {
                    // same day
                    formatter.dateFormat = "a h:m"
                    return formatter.string(from: self)
                            .replacingOccurrences(of: "PM", with: "下午")
                            .replacingOccurrences(of: "AM", with: "上午")
                }
                
                if (calendar.dateComponents([.day], from: nowComp, to: selfComp).day == 1) {
                    // yesterday
                    formatter.dateFormat = "昨天 a h:m"
                    return formatter.string(from: self)
                        .replacingOccurrences(of: "PM", with: "下午")
                        .replacingOccurrences(of: "AM", with: "上午")
                }
            }
        }
        
        // same year, other month
        formatter.dateFormat = "M月d日"
        return formatter.string(from: self)
    }
    
    
    func isToday() -> Bool {
        let calendar = Calendar.current
        let comp1 = calendar.dateComponents([.day,.month,.year], from: Date())
        let comp2 = calendar.dateComponents([.day,.month,.year], from: self)
        return (comp2.year == comp1.year) && (comp2.month == comp1.month) && (comp2.day == comp1.day)
    }
    
    func isYesterday() -> Bool {
        let calendar = Calendar.current
        let nowComponents = calendar.dateComponents([.day], from: Date() )
        let selfComponents = calendar.dateComponents([.day], from: self as Date)
        let cmps = calendar.dateComponents([.day], from: selfComponents, to: nowComponents)
        return cmps.day == 1
    }
    
    func isSameWeak() -> Bool {
        let calendar = Calendar.current
        let nowComponents = calendar.dateComponents([.year, .month, .weekday], from: Date())
        let selfComponents = calendar.dateComponents([.year, .month, .weekday], from: self)
        return nowComponents.year == selfComponents.year && nowComponents.month == selfComponents.month && nowComponents.weekday == selfComponents.weekday
    }
    
    func asWeekday() -> String {
        let weekday = Calendar.current.component(.weekday, from: self)
        var dayString = ""
        if (weekday == 1) {
            dayString = "一"
        } else if (weekday == 2) {
            dayString = "二"
        } else if (weekday == 3) {
            dayString = "三"
        } else if (weekday == 4) {
            dayString = "四"
        } else if (weekday == 5) {
            dayString = "五"
        } else if (weekday == 6) {
            dayString = "六"
        } else if (weekday == 7) {
            dayString = "日"
        }
        return "星期\(dayString)"
    }
}
