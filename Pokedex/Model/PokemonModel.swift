//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Luiz Henrique Silva Sampaio on 29/07/23.
//

import Foundation

class Pokemon {
    var name: String = ""
    var id: Int = 0
    var imageUrl: String = ""
    
    func getDataByID() {
        self.name = "placeHolder"
        self.imageUrl = "https://placeholder.com"
    }
}
