//
//  ViewController.swift
//  Pokedex
//
//  Created by Luiz Henrique Silva Sampaio on 29/07/23.
//

import UIKit

class PokemonViewController: UIViewController {
    var actualPokemonId = 1

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonId: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    func configureLayout() {
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if actualPokemonId == 1010 {
            actualPokemonId = 1
        } else {
            actualPokemonId += 1
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if actualPokemonId == 1 {
            actualPokemonId = 1010
        } else {
            actualPokemonId -= 1
        }
    }
}

