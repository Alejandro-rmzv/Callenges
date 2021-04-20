//
//  RateModel.swift
//  Challenge
//
//  Created by Alejandro Jose Ramirez Vergara on 17/04/21.
//

import Foundation

struct RatesModel: Decodable {
  let success: Bool
  let base: String?
  let date: String?
  let rates: RateModel?
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case base = "base"
        case date = "date"
        case rates = "rates"
    }
}
