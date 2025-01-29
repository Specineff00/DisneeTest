import Dependencies
import Foundation

extension DependencyValues {
  var persistentStorage: any PersistentStorage {
    get { self[PersistentStorageKey.self] }
    set { self[PersistentStorageKey.self] = newValue }
  }
}

private enum PersistentStorageKey: DependencyKey {
  static let liveValue: any PersistentStorage = LivePersistentStorage()
  static let testValue: any PersistentStorage = MockPersistentStorage(loaded: { [] })
}
