import ComposableArchitecture
import Testing
import Foundation
@testable import Disnees

@MainActor
struct DisneyCharactersFeatureTests {

  @Test
  func onAppearFirstTimeLoadsFromAPI() async throws {
    let store = TestStore(initialState: DisneyCharactersFeature.State()) {
      DisneyCharactersFeature()
    } withDependencies: {
      $0.disneesAPI = MockDisneesAPI { [.mock] }
      $0.persistentStorage = MockPersistentStorage { [] }
    }
    await store.send(\.onAppear) { state in
      state.isLoading = true
      state.characters = []
    }


    await store.receive(\.loadingResponse.success) { state in
      state.isLoading = false
      state.characters = [.mock]
    }
  }

  @Test
  func savedCharactersAreLoadedOnAppear() async throws {
    let store = TestStore(initialState: DisneyCharactersFeature.State()) {
      DisneyCharactersFeature()
    } withDependencies: {
      $0.disneesAPI = MockDisneesAPI { [] }
      $0.persistentStorage = MockPersistentStorage { [.mock] }
    }
    await store.send(\.onAppear) { state in
      state.characters = [.mock]
    }
  }

  @Test
  func alertIsShownWhenBadRequest() async throws {
    let store = TestStore(initialState: DisneyCharactersFeature.State()) {
      DisneyCharactersFeature()
    } withDependencies: {
      $0.disneesAPI = MockDisneesAPI { throw DisneeError.badRequest }
      $0.persistentStorage = MockPersistentStorage { [] }
    }

    await store.send(.onAppear) { state in
      state.isLoading = true
    }

    await store.receive(\.loadingResponse.failure) { state in
      state.isLoading = false
      state.destination = .alert(.errorState)
    }
  }
}
