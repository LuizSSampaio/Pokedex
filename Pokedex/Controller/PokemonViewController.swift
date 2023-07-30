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
        configureDatas()
    }
    
    func configureLayout() {
        navigationItem.hidesBackButton = true
        pokemonImage.layer.cornerRadius = 16.0
    }
    
    func configureDatas() {
        fetchPokemonData(actualPokemonId) { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.pokemonName.text = pokemon.name
                    self.pokemonImage.imageFrom(url: URL(string: pokemon.imageUrl)!)
                }
            case .failure(let error):
                print("Get pokemon error: \(error)")
            }
        }
        
        pokemonId.text = "\(actualPokemonId) -"
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if actualPokemonId == 1010 {
            actualPokemonId = 1
        } else {
            actualPokemonId += 1
        }
        configureDatas()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if actualPokemonId == 1 {
            actualPokemonId = 1010
        } else {
            actualPokemonId -= 1
        }
        configureDatas()
    }
}

