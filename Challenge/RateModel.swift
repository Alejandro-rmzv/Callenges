//
//  RateModel.swift
//  Challenge
//
//  Created by Alejandro Jose Ramirez Vergara on 17/04/21.
//

import Foundation

struct RateModel: Decodable {
    let USD: Float?
  
  enum CodingKeys: String, CodingKey {
    case USD = "USD"
  }
}
