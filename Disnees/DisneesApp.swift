import ComposableArchitecture
import SwiftUI

@main
struct DisneesApp: App {
  @MainActor
  static let store = Store(initialState: DisneyCharactersFeature.State()) {
    DisneyCharactersFeature()
  }

  var body: some Scene {
    WindowGroup {
      DisneyCharacterView(store: Self.store)
    }
  }
}
