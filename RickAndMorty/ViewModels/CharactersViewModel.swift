//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Sergiy Vergun on 25/04/2024.
//

import SwiftUI

enum FetchState: Equatable {
    case initial
    case loading
    case failure(Error)
    
    static func == (lhs: FetchState, rhs: FetchState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (.loading, .loading):
            return true
        case let (.failure(error1), .failure(error2)):
            // Compare errors if they are both failures
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
}

@Observable
class CharactersViewModel {
    var characters = [Character]()
    var fetchState = FetchState.initial
    var isMoreCharactersAvailable: Bool = false;
    
    private var currentPage: Int = 1
    
    func fetchCharacters(page: Int = 1) async {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") else {
            DispatchQueue.main.sync {self.fetchState = .failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))}
            return
        }
        DispatchQueue.main.sync {
            self.fetchState = .loading}
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(CharactersResponse.self, from: data)
            
            DispatchQueue.main.sync {
                
                self.characters.append(contentsOf: result.results)
                self.isMoreCharactersAvailable = result.info.next != nil
                self.currentPage = page
                self.fetchState = .initial}
            
        } catch {
            DispatchQueue.main.sync {
                self.fetchState = .failure(error)}
        }
    }
    
    
    func fetchMoreCharacters() async {
        await fetchCharacters(page: currentPage + 1)
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
