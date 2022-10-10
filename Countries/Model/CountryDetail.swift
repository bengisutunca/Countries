//
//  CountryDetail.swift
//  Countries
//
//  Created by Bengi Tunca on 8.10.2022.
//

import Foundation

struct CountryDetailModel: Decodable {
    let data: CountryDetail?
}

struct CountryDetail: Codable {
    let name: String?
    let code: String?
    let wikiDataId: String?
    let flagImageUri: String?
    
    enum CodingKeys: String, CodingKey {
        case name, code, wikiDataId, flagImageUri
    }
}
