//
//  Date.swift
//  GoogleLiveLocationAwareness
//
//  Created by Dayo Banjo on 11/8/22.
//

import Foundation


typealias YEAR_MONTH = (year: Int, month: Int)


extension Date {
    
    func daysDifference (date: Date) -> Int {
        let interval = self.timeIntervalSince1970 - date.timeIntervalSince1970
        return Int(interval/(60 * 60 * 24))
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func endOfMonthDay () -> Int {
        let date = self.endOfMonth()
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        return calendar?.component(NSCalendar.Unit.day, from: date) ?? 0
    }
    
    func format(_ format: String = "dd/MM/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func isSameDay (date: Date, date2 : Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date) == dateFormatter.string(from: date2)
    }
    
    static func isSameMonth (date: Date, date2 : Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yyyy"
        return dateFormatter.string(from: date) == dateFormatter.string(from: date2)
    }
    
    func addMonth (count : Int) -> Date? {
        var comps = DateComponents()
        comps.month = count
        
        let caledar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        if let newDate = caledar?.date(byAdding: comps, to: self, options: [])! {
            return newDate
        }
        else {
            return nil
        }
    }
    
    func addDay (day : Int) -> Date? {
        var comps = DateComponents()
        comps.day = day
        
        let caledar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        if let newDate = caledar?.date(byAdding: comps, to: self, options: [])! {
            return newDate
        }
        else {
            return nil
        }
    }
    
    func addDays (count : Int) -> Date? {
        var comps = DateComponents()
        comps.day = count
        
        let caledar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        if let newDate = caledar?.date(byAdding: comps, to: self, options: [])! {
            return newDate
        }
        else {
            return nil
        }
    }
    
    func setTime (hours: Int, minute: Int, timeType : TimeType) -> Date? {
        let hour = hours + (timeType == .AM ? 0 : 12)
        
        let calendar = NSCalendar.init(identifier: NSCalendar.Identifier.gregorian)
        if let date = calendar?.date(bySettingHour: hour, minute: minute, second: 0, of: self, options: []){
            return date
        }
        return nil
    }
    
    static func create(timeIntervalSince1970: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(timeIntervalSince1970))
    }
    
    static func createDate(value: String?) -> Date? {
        if let value = value {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: value) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sssZ"
            if let date = formatter.date(from: value) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = formatter.date(from: value) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = formatter.date(from: value) {
                return date
            }
        }
        return nil
    }
    
    func toDateProper() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: self)
    }
    
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }
    
    func toShortDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    private static let dateFormat = "yyyy-MM-dd"
    
    var format : String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = Date.dateFormat
        return dateFormatter.string(from: self)
    }
    
    func getMonth(date string: String) -> String {
        
        //        let df = DateFormatter()
        //        df.setLocalizedDateFormatFromTemplate("MMM")
        //        return df.string(from: self)
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = Date.dateFormat
        
        guard let date = formatter.date(from: string) else {
            return "Jan 2021"
        }
        
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        
        formatter.dateFormat = "MMM"
        let month = formatter.string(from: date)
        
        return "\(year) \(month)"
    }
    
    
}
enum TimeType {
    case AM, PM
}



