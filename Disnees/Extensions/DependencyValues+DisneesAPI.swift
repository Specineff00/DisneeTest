import Dependencies
import Foundation

extension DependencyValues {
  var disneesAPI: any DisneesAPI {
    get { self[DisneesAPIKey.self] }
    set { self[DisneesAPIKey.self] = newValue }
  }
}

private enum DisneesAPIKey: DependencyKey {
  static let liveValue: any DisneesAPI = LiveDisneesAPI()
  static let testValue: any DisneesAPI = MockDisneesAPI { [.mock] }
}


// TODO:
// Swipeable view lib
// Unit testing
// Error handling for loading
