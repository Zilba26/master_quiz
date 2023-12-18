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
  toString() => {
    'all': 'Toutes les catégories',
    'art_litterature': 'Art et littérature',
    'tv_cinema': 'TV et cinéma',
    'jeux_videos': 'Jeux vidéos',
    'musique': 'Musique',
    'sport': 'Sport',
    'actu_politique': 'Actualité et politique',
    'culture_generale': 'Culture générale',
  }[key]!;

}