enum Difficulty {
  easy(key: "facile"),
  medium(key: 'normal'),
  hard(key: 'difficile');

  const Difficulty({
    required this.key,
  });

  final String key;

  @override
  String toString() {
    switch (this) {
      case Difficulty.easy:
        return 'Facile';
      case Difficulty.medium:
        return 'Normal';
      case Difficulty.hard:
        return 'Difficile';
      default:
        return '';
    }
  }
}