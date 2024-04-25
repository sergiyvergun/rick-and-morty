//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Sergiy Vergun on 25/04/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CharactersViewModel()
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            switch viewModel.fetchState {
            case .loading:
                ProgressView()
            case .initial:
                EmptyView()
            case .failure(let error):
                Text(error.localizedDescription)
            }
        }
        .frame(height: 50, alignment: .center)
        .onAppear {
            viewModel.fetchMoreCharacters()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.characters, id: \.id) { character in
                    NavigationLink(destination: CharacterDetail(character: character)) {
                        CharacterListItemView(character: character)
                    }
                }
                if viewModel.isMoreCharactersAvailable {
                    lastRowView
                }
            }
            .contentMargins(.top, 10)
            .navigationBarTitle("Rick and Morty Characters", displayMode: .inline)
        }
        .onAppear(perform:{viewModel.fetchCharacters()})
        
    }
}


#Preview {
    ContentView()
}
