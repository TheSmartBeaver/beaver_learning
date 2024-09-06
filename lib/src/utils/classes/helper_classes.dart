String? findKeyByValue<T>(Map<String, T> map, T reference) {
  for (var entry in map.entries) {
    if (entry.value == reference) {
      return entry.key;
    }
  }
  return null; // Retourne null si aucune correspondance n'est trouvée
}