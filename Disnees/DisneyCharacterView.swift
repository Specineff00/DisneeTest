import CardStack
import ComposableArchitecture
import SwiftUI

struct DisneyCharacterView: View {
  @Bindable var store: StoreOf<DisneyCharactersFeature>

  var body: some View {
    GeometryReader { geo in
      CardStack(
        direction: LeftRight.direction,
        data: store.characters,
        onSwipe: { character, direction in
          print("Swiped \(character.name) to \(direction)")
        },
        content: { character, _, _ in
          DisneyCharacterCard(character: character)
        }
      )
      .frame(height: geo.size.height)

    }
    .overlay {
      if store.state.isLoading {
        ProgressView()
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .ignoresSafeArea(.all)
    .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
  }
}
