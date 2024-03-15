/// Core data/model classes for the app.
library core_entities;

export 'entities/errors/basic_exception.dart';
export 'entities/errors/basic_http_exception.dart';
export 'entities/extras/extras.dart';
export 'entities/extras/genre.dart';
export 'entities/extras/spoken_language.dart';
export 'entities/person/credits/credit_person.dart'
   show CreditPerson, Cast, Crew;
export 'entities/person/credits/credits.dart'
    show CreditsBase, Credits, TvCredits;
export 'entities/person/credits/tv_credit_person.dart'
    show TvCreditPerson, TvRoleBase, TvCast, TvCastRole, TvCrew, TvCrewRole;
export 'entities/person/person.dart';
export 'entities/products/movies/movie.dart';
export 'entities/products/movies/movie_collection.dart';
export 'entities/products/movies/movie_collection_detail.dart';
export 'entities/products/movies/movie_detail.dart';
export 'entities/products/product.dart';
export 'entities/products/product_detail.dart';
export 'entities/products/tv_shows/episode.dart';
export 'entities/products/tv_shows/season.dart';
export 'entities/products/tv_shows/tv_show.dart';
export 'entities/products/tv_shows/tv_show_detail.dart';
