//
//  WebService.swift
//  Challenge
//
//  Created by Alejandro Jose Ramirez Vergara on 17/04/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import Reachability

struct WebService {
    static func requestService(url: URLConvertible, method: HTTPMethod, parameters: Parameters, headers: HTTPHeaders? = nil, showLoaderFlag: Bool, completion: @escaping (_ success: RatesModel) -> Void) {
        /* check for internet connection */
    do{
        let reachability = try Reachability()
        try reachability.startNotifier()
        
        switch reachability.connection {
            case .cellular, .wifi:
                AF.request(url, method: method,  parameters: nil, encoding: JSONEncoding.default)
                        .responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                do{
                                    let decoder = JSONDecoder()
                                    let model = try decoder.decode(RatesModel.self, from:response.data!)
                                    completion(model)
                                }catch{
                                    print("could not start reachability notifier")
                                }
                            case .failure(let error):
                                print(error)
                            }
                    }
                break
            case .unavailable:
                let json: RatesModel = RatesModel(success: false,
                                                  base: "",
                                                  date: "",
                                                  rates: RateModel(USD: 0.0))
                                        completion(json)
                break
            default:
                break
            }
        }catch{
            
          print("could not start reachability notifier")
        }
    }
}
