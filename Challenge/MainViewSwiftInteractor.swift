//
//  VerifySmsAssociateViewSwiftInteractor.swift
//  Mi Telcel
//
//  Created Alejandro Jose Ramirez Vergara on 24/03/21.
//  Copyright © 2021 SpeedyMovil. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Alamofire

class MainViewSwiftInteractor: MainViewSwiftInteractorProtocol {
   weak var presenter: MainViewSwiftPresenterProtocol?
    ///Protocol to call ws
    func callService(with option: Int) {
        let date = Date.init()
        let ratesByDates: NSMutableDictionary = NSMutableDictionary()
        let parameters: Parameters = Parameters()
        let headers:HTTPHeaders = HTTPHeaders()
        var initDate: Date = Date.init()
        var count = 0
        var type: String = "w"
        switch option {
            case SearchCase.week.rawValue:
                initDate = date.addingTimeInterval(-6*24*60*60)
                type = "w"
                break
            case SearchCase.oneMonth.rawValue:
                initDate = date.addingTimeInterval(-9*24*60*60)
                type = "om"
                break
            case SearchCase.twoMonths.rawValue:
                initDate = date.addingTimeInterval(-14*24*60*60)
                type = "tm"
                break
            default:
                break
        }
        let arrayDates = datesRange(from: initDate, to: date)
        let numberOfDays = arrayDates.count
        for dateCompare: Date in arrayDates{
            let dateStr = dateCompare.getFormattedDate(format: Constants.formatDate)
            if let url: URLConvertible = URL(string: "\(Constants.endPoint)\(dateStr)?access_key=\(Constants.apiKey)&symbols=\(Constants.apiSymbol)"){
                WebService.requestService(url: url, method: .get, parameters: parameters, headers: headers, showLoaderFlag: false, completion: {response in
                    count += 1
                    if response.success{
                        ratesByDates[response.date ?? ""] = response.rates?.USD
                    }
                    if count == numberOfDays{
                        let dateKey = date.getFormattedDate(format: Constants.formatDate)
                        let key: String = "\(dateKey)\(type)"
                        let userDefaults = UserDefaults.standard
                        userDefaults.setValue(ratesByDates, forKey: key)
                        userDefaults.setValue(dateKey, forKey: "Date")
                        userDefaults.synchronize()
                        self.presenter?.showGrafic(with: ratesByDates)
                    }
                })
            }
        }
    }
}