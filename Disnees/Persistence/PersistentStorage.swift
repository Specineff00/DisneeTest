import Foundation

protocol PersistentStorage {
  func loadCharacters() -> [DisneyCharacter]
  func saveCharacters(_ characters: [DisneyCharacter])
}


struct LivePersistentStorage: PersistentStorage {
  func loadCharacters() -> [DisneyCharacter] {
    guard let url = getFileURL() else { return [] }
    do {
      let data = try Data(contentsOf: url)
      return try JSONDecoder().decode([DisneyCharacter].self, from: data)
    } catch {
      //We don't want to display errors but want to know about it
      print("Failed to load array: \(error)")
      return []
    }
  }

  func saveCharacters(_ characters: [DisneyCharacter]) {
    guard let url = getFileURL() else { return }
    do {
      let data = try JSONEncoder().encode(characters)
      try data.write(to: url)
      print("Array saved to file at \(url)")
    } catch {
      //We don't want to display errors but want to know about it
      print("Failed to save array: \(error)")
    }
  }

  private func getFileURL() -> URL? {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths.first?.appendingPathComponent("DisneyCharacters.json")
  }
}

struct MockPersistentStorage: PersistentStorage {
  let loaded: () -> [DisneyCharacter]

  init(loaded: @escaping () -> [DisneyCharacter]) {
    self.loaded = loaded
  }

  func loadCharacters() -> [DisneyCharacter] {
    return loaded()
  }
  
  func saveCharacters(_ characters: [DisneyCharacter]) {
  }
}
