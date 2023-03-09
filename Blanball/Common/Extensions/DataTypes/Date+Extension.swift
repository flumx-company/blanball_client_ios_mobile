//
//  Date+Extension.swift
//  Blanball
//
//  Created by Misha Deneka on 09.03.2023.
//

import Foundation

extension Date {
    var yesterdayDate: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)! // swiftlint:disable:this force_unwrapping
    }
    
    var tomorrowDate: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)! // swiftlint:disable:this force_unwrapping
    }
    
    var day: Int {
        let components = Calendar.current.dateComponents([.day], from: self)
        return components.day ?? 0
    }
    
    var month: Int {
        let components = Calendar.current.dateComponents([.month], from: self)
        return components.month ?? 0
    }
    
    var year: Int {
        let components = Calendar.current.dateComponents([.year], from: self)
        return components.year ?? 0
    }
    
    var lastDayInCurrentMonth: Int {
        guard let lastDayInCurrentMonthDate = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1),
                                                                    to: self) else { return 0 }
        return lastDayInCurrentMonthDate.day
    }
    
    
    func daysFrom(date: Date) -> Int {
        let diff = Calendar.current.dateComponents([.day], from: self, to: date)
        return diff.day ?? 0
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
