//
//  BeerService.swift
//  Avaloq-TestApp
//
//  Created by Sergey Libin on 09.06.2022.
//

import Foundation

enum BeerService {
    case beers(page: Int, number: Int)
}

extension BeerService: Service {
    var baseURL: String {
        return "https://api.punkapi.com"
    }
    
    var path: String {
        switch self {
        case .beers(_,_):
            return "/v2/beers"
        }
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        
        switch self {
        case .beers(let page, let number):
            params["page"] = String(page)
            params["per_page"] = String(number)
        }
        return params
    }
    
    var method: ServiceMethod {
        return .get
    }
}
