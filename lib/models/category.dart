enum Category {
  all(key: ''),
  artLitterature(key: 'art_litterature'),
  tvCinema(key: 'tv_cinema'),
  jeuxVideo(key: 'jeux_videos'),
  musique(key: 'musique'),
  sport(key: 'sport'),
  actuPolitique(key: 'actu_politique'),
  cultureGenerale(key: 'culture_generale');

  const Category({
    required this.key,
  });

  final String key;

  @override
  String toString() {
    switch (this) {
      case Category.all:
        return 'Toutes les catégories';
      case Category.artLitterature:
        return 'Art et Littérature';
      case Category.tvCinema:
        return 'TV et Cinéma';
      case Category.jeuxVideo:
        return 'Jeux Vidéos';
      case Category.musique:
        return 'Musique';
      case Category.sport:
        return 'Sport';
      case Category.actuPolitique:
        return 'Actualité et Politique';
      case Category.cultureGenerale:
        return 'Culture Générale';
      default:
        return '';
    }
  }
}