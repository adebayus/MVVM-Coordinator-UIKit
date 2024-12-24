//
//  DateFormtter+Extension.swift
//  UIKitCoordinator
//
//  Created by MacBook Air MII  on 23/12/24.
//

import Foundation

extension DateFormatter {
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.calendar = Calendar(identifier: .gregorian)
        
        return df
    }()
    
    static func utcToGmt7Date(
        date: String,
        outputFormatDate: String? = "yyyy-MM-dd HH:mm:ss"
    ) -> Date? {
       
        guard let removeDot = date.components(separatedBy: ".").first else { return nil}
        let df = DateFormatter.dateFormatter
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let convertToDate = df.date(from: removeDot)  {
            
            var calendar = Calendar(identifier: .gregorian)
            calendar.locale = Locale(identifier: "en_US_POSIX")
            
            let gmt7 = calendar.date(byAdding: .hour, value: 7, to: convertToDate)
            
            return gmt7
        }
        
        return nil
        
    }
    
}

extension Date {
    
    static func getDayNowGMT7() -> Date? {
        let now = Date()
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        
        let gmt7 = calendar.date(byAdding: .hour, value: 7, to: now)
        
        return gmt7
    }
    
    static func getStartEndDay(date: Date) -> (Date, Date)? {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        
        var startOfDay = calendar.startOfDay(for: date)
        startOfDay = calendar.date(byAdding: .hour, value: 7, to: startOfDay) ?? startOfDay
        
        var endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) ?? Date()
        endOfDay = calendar.date(byAdding: .second, value: -1, to: endOfDay) ?? Date()
        
        return (startOfDay,endOfDay)
    }
    
    static func isYesterday(date: Date) -> Bool {
        
        let now = Date.getDayNowGMT7()!
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        
        let yesterdayDate = calendar.date(byAdding: .day, value: -1, to: now) ?? Date()
        
        if let yesterdayStarEndDay = getStartEndDay(date: yesterdayDate) {
            let range = yesterdayStarEndDay.0...yesterdayStarEndDay.1
            return range.contains(date)
        }
  
        return false
    }
    
    static func isInWeekAgo(date: Date) -> Bool {
        let now = Date.getDayNowGMT7()!
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: now) ?? Date()
        let weekAgoStartEnd = getStartEndDay(date: weekAgo)
        
        let twoDayAgo = calendar.date(byAdding: .day, value: -2, to: now) ?? Date()
        let twoDayStartEnd = getStartEndDay(date: twoDayAgo)
        
        if let weekAgoStartEnd = weekAgoStartEnd, let twoDayStartEnd = twoDayStartEnd {
            
            let range = weekAgoStartEnd.0...twoDayStartEnd.1
            
            return range.contains(date)
        }
        
        return false

    }
    
    static func isToday(date: Date) -> Bool {
        
        let now = Date.getDayNowGMT7()!
        if let nowStartEnd = getStartEndDay(date: now) {
            let range = nowStartEnd.0...nowStartEnd.1
            return range.contains(date)
        }
        return false
    }
    
}
