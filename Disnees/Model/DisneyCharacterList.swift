import Foundation

struct DisneyCharactersList {
  let disneyCharacters: [DisneyCharacter]
}

extension DisneyCharactersList: Decodable {
  enum CodingKeys: String, CodingKey {
    case disneyCharacters = "data"
  }
}

struct DisneyCharacterListRequest: Request {
  typealias ReturnType = DisneyCharactersList
  let path = "/character"
}
