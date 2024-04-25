//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Sergiy Vergun on 25/04/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CharactersViewModel()
    @State private var showToast = true
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            switch viewModel.fetchState {
            case .loading:
                ProgressView()
            case .initial:
                EmptyView()
            case .failure(_):
                Text("An error occurred")
            }
        }
        .frame(height: 50, alignment: .center)
        .task{await viewModel.fetchMoreCharacters( )}
    }
    
    var body: some View {
        NavigationView {
            if viewModel.characters.isEmpty{
                switch viewModel.fetchState {
                case .initial:
                    EmptyView()
                    
                case .loading:
                    ProgressView().controlSize(.large)
                    
                case .failure(_):
                    VStack(spacing: 10){
                        Image(systemName: "xmark.octagon").resizable().frame(width: 60,height: 60).foregroundColor(.red)
                        Text("An error occurred").foregroundColor(.red).font(.title2)
                        
                        Button(action: {
                            Task{
                                await viewModel.fetchCharacters()
                            }
                        }, label: {
                            Text("Retry").foregroundColor(.secondary)
                        })
                    }
                }
            } else {
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
                .navigationBarTitle("Rick and Morty Characters", displayMode: .inline)}
        }
        .task{ await viewModel.fetchCharacters( )}
        
    }
}


#Preview {
    ContentView()
}
