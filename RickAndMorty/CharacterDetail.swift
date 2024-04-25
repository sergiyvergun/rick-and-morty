//
//  CharacterDetail.swift
//  RickAndMorty
//
//  Created by Sergiy Vergun on 25/04/2024.
//

import SwiftUI

struct CharacterDetail: View {
    let character: Character
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CharacterDetail(character: Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "", origin: Origin(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"), location: Location(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [], url: "", created: ""))
}
