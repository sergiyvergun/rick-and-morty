//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Sergiy Vergun on 25/04/2024.
//

import SwiftUI

enum FetchState {
    case initial
    case loading
    case failure(Error)
}

class CharactersViewModel: ObservableObject {
    @Published var characters = [Character]()
    @Published var fetchState = FetchState.initial
    @Published var isMoreCharactersAvailable: Bool = false;
    
    private var currentPage: Int = 1
    
    func fetchCharacters(page: Int = 1) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") else {
            print("Invalid URL")
            return
        }
        self.fetchState = .loading
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.fetchState = .failure(error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(CharactersResponse.self, from: data)
                DispatchQueue.main.async {
                    self.characters.append(contentsOf: result.results)
                    self.isMoreCharactersAvailable = result.info.next != nil
                    self.currentPage = page
                    self.fetchState = .initial
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.fetchState = .failure(error)
                }
            }
        }.resume()
    }
    
    func fetchMoreCharacters() {
        fetchCharacters(page: currentPage + 1)
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
