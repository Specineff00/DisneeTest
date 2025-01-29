import Foundation

struct DisneyCharacter: Identifiable {
    let id: Int
    let films, shortFilms: [String]
    let parkAttractions: [String]
    let name: String
    let imageURL: String?
}

extension DisneyCharacter: Codable {
  enum CodingKeys: String, CodingKey {
      case id = "_id"
      case films, shortFilms, parkAttractions, name
      case imageURL = "imageUrl"
  }
}


extension DisneyCharacter {
  static let mock = DisneyCharacter(
    id: 1,
    films: ["film 1", "film 2", "film 3"],
    shortFilms: ["short film 1 ", "short film 2", "short film 3"],
    parkAttractions: ["park attraction 1", "park attraction 2", "park attraction 3"],
    name: "Spongebob Squarepants",
    imageURL: "https://www.cartoonpics.net/data/media/37/spongebob_squarepants_hd.jpg"
  )
}

extension DisneyCharacter: Equatable {}
