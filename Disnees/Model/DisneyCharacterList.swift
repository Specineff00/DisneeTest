import Foundation

struct DisneyCharactersList {
  let disneyCharacters: [DisneyCharacter]
}

extension DisneyCharactersList: Decodable {
  enum CodingKeys: String, CodingKey {
    case disneyCharacters = "data"
  }
}
