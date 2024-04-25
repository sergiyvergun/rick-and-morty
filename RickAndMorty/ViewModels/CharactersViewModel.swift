//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Sergiy Vergun on 25/04/2024.
//

import SwiftUI

class CharactersViewModel: ObservableObject {
    @Published var characters = [Character]()
    
    func fetchCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CharactersResponse.self, from: data)
                DispatchQueue.main.async {
                    self.characters = result.results
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct CharactersResponse: Codable {
    let info: CharactersResponseInfo
    let results: [Character]
}

struct CharactersResponseInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}








