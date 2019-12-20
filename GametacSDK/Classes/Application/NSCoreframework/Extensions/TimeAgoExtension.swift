//
//  TimeAgoExtension.swift
//  MobiHair Customer
//
//  Created by Duong Viet Cuong on 10/19/17.
//  Copyright © 2017 newsoft. All rights reserved.
//

import UIKit

class TimeHelper:NSObject{
    
    static func timeAgoSince(_ datex: Date?) -> String {
        if let date = datex{
            let calendar = Calendar.current
            let now = Date()
            let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
            let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
            
            if let year = components.year, year >= 2 {
                return "\(year) năm trước"
            }
            
            if let year = components.year, year >= 1 {
                return "Năm ngoái"
            }
            
            if let month = components.month, month >= 2 {
                return "\(month) tháng trước"
            }
            
            if let month = components.month, month >= 1 {
                return "Tháng trước"
            }
            
            if let week = components.weekOfYear, week >= 2 {
                return "\(week) tuần trước"
            }
            
            if let week = components.weekOfYear, week >= 1 {
                return "Tuần trước"
            }
            
            if let day = components.day, day >= 2 {
                return "\(day) ngày trước"
            }
            
            if let day = components.day, day >= 1 {
                return "Ngày hôm qua"
            }
            
            if let hour = components.hour, hour >= 2 {
                return "\(hour) giờ trước"
            }
            
            if let hour = components.hour, hour >= 1 {
                return "Trước đây 1 tiếng"
            }
            
            if let minute = components.minute, minute >= 2 {
                return "\(minute) phút trước đây"
            }
            
            if let minute = components.minute, minute >= 1 {
                return "1 phút trước"
            }
            
            if let second = components.second, second >= 3 {
                return "\(second) giây trước"
            }
            
        }
        
        return "Gần đây"
        
    }
}
