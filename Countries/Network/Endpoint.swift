//
//  Endpoint.swift
//  Countries
//
//  Created by Bengi Tunca on 7.10.2022.
//

import Foundation

struct Endpoint {
    var path: String
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "wft-geo-db.p.rapidapi.com"
        components.path = "/v1" + path
        components.queryItems = [
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "rapidapi-key", value: "d04e692e7emshc2a836a5d31c955p12f112jsn717b606ccc3b")
        ]
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}

extension Endpoint {
    
    static func getCountries(limit: String) -> URL {
        Endpoint(path: "/geo/countries/").url
    }
}
