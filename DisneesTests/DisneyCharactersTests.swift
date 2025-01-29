import Testing
import Foundation
@testable import Disnees

@MainActor
struct DisneyCharactersTests {
  @Test
  func sortedByPopularity() {
      let characters: [DisneyCharacter] = [
        .init(id: 1, films: ["film1"], shortFilms: ["shortFilm1"], parkAttractions: [], name: "1", imageURL: nil),
        .init(id: 2, films: ["film1", "film2"], shortFilms: ["shortFilm1"], parkAttractions: [], name: "1", imageURL: nil),
        .init(id: 3, films: ["film1"], shortFilms: ["shortFilm1", "shortFilm2", "shortFilm3"], parkAttractions: ["parkAttraction1"], name: "1", imageURL: nil),
        .init(id: 4, films: [], shortFilms: [], parkAttractions: [], name: "1", imageURL: nil)
      ]

    let expected: [DisneyCharacter] = [
      .init(id: 3, films: ["film1"], shortFilms: ["shortFilm1", "shortFilm2", "shortFilm3"], parkAttractions: ["parkAttraction1"], name: "1", imageURL: nil),
      .init(id: 2, films: ["film1", "film2"], shortFilms: ["shortFilm1"], parkAttractions: [], name: "1", imageURL: nil),
      .init(id: 1, films: ["film1"], shortFilms: ["shortFilm1"], parkAttractions: [], name: "1", imageURL: nil),
      .init(id: 4, films: [], shortFilms: [], parkAttractions: [], name: "1", imageURL: nil)
      ]

    #expect(characters.sortedByPopularity() == expected)
  }
}
