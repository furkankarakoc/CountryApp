//
//  Countries.swift
//  CountryApp
//
//  Created by furkankarakoc on 21.05.2022.
//

import Foundation

struct Countries: Decodable {
    let subregion: String?
    let name: Names
    let flag: String?
    let currencies: [String: [String: String]?]?
    let languages: [String: String]?
    let latlng: [Float]?
}

struct Names: Decodable {
    var common: String
    let nativeName: [String: [String: String]?]?
}

