import Foundation

extension [DisneyCharacter] {
  func sortedByPopularity() -> Self {
    sorted { $0.films.count + $0.shortFilms.count + $0.parkAttractions.count > $1.films.count + $1.shortFilms.count + $1.parkAttractions.count }
  }
}
