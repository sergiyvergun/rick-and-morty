//
//  CharacterListItemView.swift
//  RickAndMorty
//
//  Created by Sergiy Vergun on 25/04/2024.
//

import SwiftUI

struct CharacterListItemView: View {
    let character: Character
    
    var body: some View {
        HStack(spacing:15) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
            } placeholder: {
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundColor(.secondary)
                    .padding(.all,10)
            }
            .aspectRatio(contentMode: .fit)
            
            .frame(width: 60, height: 60)
            .clipShape(.rect(cornerRadius: 10))
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                Text("Status: \(character.status)")
                    .font(.subheadline).foregroundColor(.secondary)
            }
        }.padding(.vertical,5)
    }
}

struct CharacterListItemView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListItemView(character: Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "", origin: Origin(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"), location: Location(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [], url: "", created: ""))
    }
}



