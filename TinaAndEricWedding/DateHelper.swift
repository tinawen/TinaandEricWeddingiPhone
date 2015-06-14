//
//  DateHelper.swift
//  TinaAndEricWedding
//
//  Created by tina on 6/14/15.
//  Copyright (c) 2015 tina. All rights reserved.
//

class DateHelper {
    class func weddingDate() -> NSDate {
        let components = NSDateComponents()
        components.day = 3
        components.month = 10
        components.year = 2015
        components.hour = 18
        components.minute = 0
        components.second = 0
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        calendar!.timeZone = NSTimeZone(abbreviation: "EST")!
        return calendar!.dateFromComponents(components)!
    }
}
