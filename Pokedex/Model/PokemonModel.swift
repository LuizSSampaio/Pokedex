//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Luiz Henrique Silva Sampaio on 29/07/23.
//

import Foundation

struct Pokemon: Decodable {
    var name: String
    var imageUrl: String
    
    enum RootKeys: String, CodingKey {
        case name, sprites
    }
    
    enum SpriteKeys: String, CodingKey {
        case front_default
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootKeys.self)
        name = try rootContainer.decode(String.self, forKey: .name)
        
        let spritesContainer = try rootContainer.nestedContainer(keyedBy: SpriteKeys.self, forKey: .sprites)
        imageUrl = try spritesContainer.decode(String.self, forKey: .front_default)
    }
}

func fetchPokemonData(_ id: Int, completion: @escaping (Result<Pokemon, Error>) -> Void) {
    let apiUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/")!
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: apiUrl) { data, response, error in
        if let error = error {
            print("API ERROR 01: \(error)")
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "API Error", code: statusCode, userInfo: nil)
                print("API ERROR 02: \(error)")
                completion(.failure(error))
                return
        }
        
        guard let jsonData = data else {
                let error = NSError(domain: "API Error", code: -1, userInfo: nil)
                print("API ERROR 03: \(error)")
                completion(.failure(error))
                return
            }
        
        do {
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: jsonData)
            completion(.success(pokemon))
        } catch {
            print("Decoding ERROR: \(error)")
            completion(.failure(error))
        }
    }
    
    task.resume()
}
