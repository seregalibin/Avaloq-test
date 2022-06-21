//
//  BeerModel.swift
//  Avaloq-TestApp
//
//  Created by Sergey Libin on 09.06.2022.
//

import Foundation

struct BeerModel: Codable {
    let imageUrl: String
    let tagline: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case tagline, description
        case imageUrl = "image_url"
    }
}
