import Foundation

enum DisneeError: Error {
  case badRequest
  case load(Error)
}
