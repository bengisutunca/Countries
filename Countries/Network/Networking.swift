//
//  Networking.swift
//  Countries
//
//  Created by Bengi Tunca on 7.10.2022.
//

import Foundation

class Networking {
    
    let apiService: APIService
    
    init(apiService: APIService = APIService()) {
        self.apiService =  apiService
    }
    
    func countryList(limit: String, completion: @escaping (Result<CountryModel, APIError>) -> Void) {
        apiService.loadData(from: Endpoint.getCountries(limit: limit)) { (result: Result<CountryModel, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func countryDetails(code: String, completion: @escaping (Result<CountryDetailModel, APIError>) -> Void) {
        apiService.loadData(from: Endpoint.getCountryDetails(code: code)) { (result: Result<CountryDetailModel, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
