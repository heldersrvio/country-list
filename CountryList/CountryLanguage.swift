//
//  CountryLanguage.swift
//  CountryList
//
//  Created by Helder on 30/07/20.
//  Copyright © 2020 Helder de Melo Sérvio Filho. All rights reserved.
//

class CountryLanguage: Decodable, Encodable {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
