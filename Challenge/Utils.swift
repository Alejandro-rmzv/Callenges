//
//  Utils.swift
//  Challenge
//
//  Created by Alejandro Jose Ramirez Vergara on 20/04/21.
//

import Foundation

///Method to order rates values
func orderRates(with data: NSMutableDictionary, keys:NSArray) ->NSArray{
    let orderData: NSMutableArray = NSMutableArray()
    for key in keys{
        orderData.add(data.object(forKey: key) ?? 0.0)
    }
    return orderData
}
///Method to order key rates
func orderKeys(with data: NSMutableDictionary) ->NSArray{
    let keys:NSArray = data.allKeys as NSArray
    let formatter = DateFormatter()
    formatter.dateFormat = Constants.formatDate
    let output = keys.sorted { string1, string2 in
        guard let date1 = formatter.date(from: string1 as! String) else { return true }
        guard let date2 = formatter.date(from: string2 as! String) else { return false }
    return date1 < date2
    }
    return output as NSArray
}
///Method to get dates from a range of dates
func datesRange(from: Date, to: Date) -> [Date] {
    // in case of the "from" date is more than "to" date,
    // it should returns an empty array:
    if from > to { return [Date]() }

    var tempDate = from
    var array = [tempDate]

    while tempDate < to {
        tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
        array.append(tempDate)
    }

    return array
}
