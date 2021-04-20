//
//  Extensions.swift
//  Challenge
//
//  Created by Alejandro Jose Ramirez Vergara on 19/04/21.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.timeZone = TimeZone(abbreviation: "GMT")
        dateformat.locale = Locale.current
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

