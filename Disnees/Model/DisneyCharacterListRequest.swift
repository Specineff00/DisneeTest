import Foundation

struct DisneyCharacterListRequest: Request {
  typealias ReturnType = DisneyCharactersList
  let path = "/character"
}
