//
//  CountryCurrency.swift
//  CountryList
//
//  Created by Helder on 30/07/20.
//  Copyright © 2020 Helder de Melo Sérvio Filho. All rights reserved.
//

class CountryCurrency: Decodable, Encodable {
    var code: String?
    
    init(code: String?) {
        self.code = code
    }
}
