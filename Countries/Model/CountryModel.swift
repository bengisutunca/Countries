//
//  CountryModel.swift
//  Countries
//
//  Created by Bengi Tunca on 7.10.2022.
//

import Foundation

struct CountryModel: Decodable {
    let data: [Country]
}

struct Country: Codable {
    let code: String?
    let name: String?
    let wikiDataID: String
    
    enum CodingKeys: String, CodingKey {
        case code, name
        case wikiDataID = "wikiDataId"
    }
}
