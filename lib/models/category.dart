enum Category {
  all(key: ''),
  artLiterature(key: 'art_litterature'),
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
}