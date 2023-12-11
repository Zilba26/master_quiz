enum Difficulty {
  easy(key: "facile"),
  medium(key: 'normal'),
  hard(key: 'difficile');

  const Difficulty({
    required this.key,
  });

  final String key;
}