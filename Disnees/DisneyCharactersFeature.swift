import ComposableArchitecture

@Reducer
struct DisneyCharactersFeature {
  @Reducer
  enum Destination {
    case alert(AlertState<Alert>)

    @CasePathable
    enum Alert {
      case error
    }
  }

  @ObservableState
  struct State: Equatable {
    @Presents var destination: Destination.State?
    var isLoading: Bool = false
    var characters: [DisneyCharacter] = []
  }

  enum Action: Sendable {
    case onAppear
    case destination(PresentationAction<Destination.Action>)
    case loadingResponse(Result<[DisneyCharacter], DisneeError>)
  }

  @Dependency(\.dismiss) var dismiss
  @Dependency(\.disneesAPI) var disneesAPI
  @Dependency(\.persistentStorage) var persistentStorage

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.characters = persistentStorage.loadCharacters()
        // If empty then attempt to load from API
        if state.characters.isEmpty {
          state.isLoading = true
          return whenLoading()
        } else {
          return .none
        }
      case .destination: // Empty due to only use of the single action alert
        return .none
      case .loadingResponse(let response):
        state.isLoading = false
        switch response {
        case .success(let characters):
          state.characters = characters.sortedByPopularity()
          return .none
        case .failure:
          state.destination = .alert(.errorState)
          return .none
        }
      }
    }
    .ifLet(\.$destination, action: \.destination)
  }


  private func whenLoading() -> Effect<Action> {
    return .run { send in
      do {
        //Fetch from API
        let characters = try await disneesAPI.fetchAllCharacters()
        //Save to storage
        persistentStorage.saveCharacters(characters)
        //Load characters
        await send(.loadingResponse(.success(characters)))
      } catch {
        await send(.loadingResponse(.failure(.load(error))))
      }
    }
  }
}

extension DisneyCharactersFeature.Destination.State: Equatable {}

