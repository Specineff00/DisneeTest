import ComposableArchitecture

extension AlertState where Action == DisneyCharactersFeature.Destination.Alert {
  static let errorState = Self {
    TextState("Oops!")
  } actions: {
    ButtonState(role: .cancel) {
      TextState("OK")
    }
  } message: {
    TextState("Something went wrong!")
  }
}
