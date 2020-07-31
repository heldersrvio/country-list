//
//  CountryInfo.swift
//  CountryList
//
//  Created by Helder on 30/07/20.
//  Copyright © 2020 Helder de Melo Sérvio Filho. All rights reserved.
//

class CountryInfo: Decodable, Encodable {
    var name: String
    var alpha2Code: String
    var capital: String
    var population: Int
    var currencies: [CountryCurrency]
    var languages: [CountryLanguage]
    
    init(name: String, alpha2Code: String, capital: String, population: Int, currencies: [CountryCurrency], languages: [CountryLanguage]) {
        self.name = name
        self.alpha2Code = alpha2Code
        self.capital = capital
        self.population = population
        self.currencies = currencies
        self.languages = languages
    }
}
