import SwiftUI

struct CharacterDetail: View {
    let character: Character
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Character image and name
                HStack(spacing: 15) {
                    AsyncImage(url: URL(string: character.image)) { image in
                        image
                            .resizable()
                            .frame(width: 150, height: 150)
                            .aspectRatio(contentMode: .fit)
                        
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                    }.clipShape(.rect(cornerRadius: 20))
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(character.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Status: \(character.status)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                
                LabeledPropertyView(label: "Species", value: character.species)
                LabeledPropertyView(label: "Gender", value: character.gender)
                LabeledPropertyView(label: "Origin", value: character.origin.name)
                LabeledPropertyView(label: "Location", value: character.location.name)
                
                
            }
            .padding()
        }
        
    }
}

struct CharacterDetail_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail(character: Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: Origin(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"), location: Location(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: [], url: "", created: ""))
    }
}
