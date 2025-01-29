import SwiftUI

struct DisneyCharacterCard: View {
  let character: DisneyCharacter

  private var hasNofilmsAndAttractions: Bool {
    character.films.isEmpty &&
    character.shortFilms.isEmpty &&
    character.parkAttractions.isEmpty
  }

  var body: some View {
    GeometryReader { geo in
      VStack(spacing: 0) {
        ZStack {
          AsyncImage(url: URL(string: character.imageURL ?? "")) { image in
            image.resizable()
          } placeholder: {
            Image(systemName: "photo.badge.exclamationmark.fill")
          }
          nameText
        }
        .frame(height: geo.size.height * 0.4)
        .background(.gray)
        if hasNofilmsAndAttractions {
          ZStack {
            Color.gray
            Text("No films or attractions found")
          }
        } else {
          characterInfoList
        }
      }
    }
  }

  private var characterInfoList: some View {
    List {
      if !character.films.isEmpty {
        Section(header: Text("Films")) {
          ForEach(character.films, id: \.self) { film in
            Text(film)
          }
        }
      }

      if !character.shortFilms.isEmpty {
        Section(header: Text("Short films")) {
          ForEach(character.shortFilms, id: \.self) { film in
            Text(film)
          }
        }
      }

      if !character.parkAttractions.isEmpty {
        Section(header: Text("Short films")) {
          ForEach(character.parkAttractions, id: \.self) { attraction in
            Text(attraction)
          }
        }
      }
    }
    .listStyle(.grouped)
  }

  private var nameText: some View {
    VStack {
      Spacer()
      HStack {
        Text(character.name)
          .font(.system(size: 20, weight: .semibold, design: .serif))
          .lineLimit(nil)
          .padding()
          .foregroundStyle(.white)
        Spacer()
      }
    }
  }
}

#Preview {
  DisneyCharacterCard(character: .mock)
}
