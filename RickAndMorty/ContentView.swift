//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Sergiy Vergun on 25/04/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CharactersViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                
                NavigationLink(destination: CharacterDetail(character: character))
                { CharacterListItemView(character: character);}
                
                
            }.contentMargins(.top, 10)
                .navigationBarTitle("Rick and Morty Characters", displayMode: .inline)
        }.onAppear(perform: viewModel.fetchCharacters)
        
    }
}


#Preview {
    ContentView()
}
