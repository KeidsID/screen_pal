import 'dart:convert';

import 'package:screen_pal/core/entities/movies/movie.dart';
import 'package:screen_pal/core/entities/movies/movie_collection_detail.dart';
import 'package:screen_pal/core/entities/movies/movie_detail.dart';
import 'package:screen_pal/infrastructures/tmdb/models/movies/movie_list_res_body.dart';
import 'package:screen_pal/infrastructures/tmdb/models/movies/raw_movie_collection_detail.dart';
import 'package:screen_pal/infrastructures/tmdb/models/movies/raw_movie_detail.dart';

const dummyMovieListResBodyJson = '''{
  "dates": {
    "maximum": "2023-08-17",
    "minimum": "2023-06-30"
  },
  "page": 1,
  "results": [
    {
      "adult": false,
      "backdrop_path": "/2vFuG6bWGyQUzYS9d69E5l85nIz.jpg",
      "genre_ids": [
        28,
        12,
        878
      ],
      "id": 667538,
      "original_language": "en",
      "original_title": "Transformers: Rise of the Beasts",
      "overview": "When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth.",
      "popularity": 2359.007,
      "poster_path": "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg",
      "release_date": "2023-06-06",
      "title": "Transformers: Rise of the Beasts",
      "video": false,
      "vote_average": 7.5,
      "vote_count": 2582
    }
  ],
  "total_pages": 1,
  "total_results": 1
}''';

/// Refer to [dummyMovieListResBodyJson] for the props values.
final dummyMovieListResBody =
    MovieListResBody.fromJson(jsonDecode(dummyMovieListResBodyJson));

/// Refer to [dummyMovieListResBodyJson] for the props values.
final Movie dummyMovie = dummyMovieListResBody.results[0].toEntity();

const dummyRawMovieDetailJson = '''{
  "adult": false,
  "backdrop_path": "/A1EWX46DxpEuiha7K0XY6vhWbdZ.jpg",
  "belongs_to_collection": {
    "id": 23456,
    "name": "One Piece Collection",
    "poster_path": "/89eVIW6qPr2x6DrsphrqKQAoMRM.jpg",
    "backdrop_path": "/3RqSKjokWlXyTBUt3tcR9CrOG57.jpg"
  },
  "budget": 0,
  "genres": [
    {
      "id": 16,
      "name": "Animation"
    },
    {
      "id": 12,
      "name": "Adventure"
    },
    {
      "id": 28,
      "name": "Action"
    },
    {
      "id": 14,
      "name": "Fantasy"
    }
  ],
  "homepage": "https://www.onepiece-filmred.com",
  "id": 900667,
  "imdb_id": "tt16183464",
  "original_language": "ja",
  "original_title": "ONE PIECE FILM RED",
  "overview": "Uta — the most beloved singer in the world. Her voice, which she sings with while concealing her true identity, has been described as “otherworldly.” She will appear in public for the first time at a live concert. As the venue fills with all kinds of Uta fans — excited pirates, the Navy watching closely, and the Straw Hats led by Luffy who simply came to enjoy her sonorous performance — the voice that the whole world has been waiting for is about to resound.",
  "popularity": 309.999,
  "poster_path": "/ogDXuVkO92GcETZfSofXXemw7gb.jpg",
  "production_companies": [
    {
      "id": 5542,
      "logo_path": "/ayE4LIqoAWotavo7xdvYngwqGML.png",
      "name": "Toei Animation",
      "origin_country": "JP"
    },
    {
      "id": 2918,
      "logo_path": "/gyEWUBWwqrm3H5T2hkERD9LxpOq.png",
      "name": "Shueisha",
      "origin_country": "JP"
    },
    {
      "id": 5822,
      "logo_path": "/qyTbRgCyU9NLKvKaiQVbadtr7RY.png",
      "name": "Toei Company",
      "origin_country": "JP"
    },
    {
      "id": 3341,
      "logo_path": "/dTG5dXE1kU2mpmL9BNnraffckLU.png",
      "name": "Fuji Television Network",
      "origin_country": "JP"
    },
    {
      "id": 155586,
      "logo_path": "/rogLuRSNdqLI9r29ZCzD0i0kfJW.png",
      "name": "Bandai",
      "origin_country": "JP"
    },
    {
      "id": 12502,
      "logo_path": "/tlBbCuZditAuvzDdIDjjnGLJUpc.png",
      "name": "Bandai Namco Entertainment",
      "origin_country": "JP"
    },
    {
      "id": 173235,
      "logo_path": null,
      "name": "ADK Emotions",
      "origin_country": "JP"
    },
    {
      "id": 1778,
      "logo_path": "/b5rT6VbYza3LyfltCmz1OcqzWJM.png",
      "name": "dentsu",
      "origin_country": "JP"
    }
  ],
  "production_countries": [
    {
      "iso_3166_1": "JP",
      "name": "Japan"
    }
  ],
  "release_date": "2022-08-06",
  "revenue": 150797338,
  "runtime": 115,
  "spoken_languages": [
    {
      "english_name": "Japanese",
      "iso_639_1": "ja",
      "name": "日本語"
    }
  ],
  "status": "Released",
  "tagline": "An almighty voice. With fiery red locks.",
  "title": "One Piece Film Red",
  "video": false,
  "vote_average": 7.4,
  "vote_count": 705
}''';

/// Refer to [dummyRawMovieDetailJson] for the props values.
final dummyRawMovieDetail =
    RawMovieDetail.fromJson(jsonDecode(dummyRawMovieDetailJson));

/// Refer to [dummyRawMovieDetailJson] for the props values.
final MovieDetail dummyMovieDetail = dummyRawMovieDetail.toEntity();

const dummyRawMovieCollectionDetailJson = '''{
  "id": 230,
  "name": "The Godfather Collection",
  "overview": "Francis Ford Coppola’s trilogy films about the everyday life of a New York mafia family. With its star-studded cast these films would go down in history as some of the greatest Hollywood has ever produced.",
  "poster_path": "/zqV8MGXfpLZiFVObLxpAI7wWonJ.jpg",
  "backdrop_path": "/3WZTxpgscsmoUk81TuECXdFOD0R.jpg",
  "parts": [
    {
      "adult": false,
      "backdrop_path": "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg",
      "id": 238,
      "title": "The Godfather",
      "original_language": "en",
      "original_title": "The Godfather",
      "overview": "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
      "poster_path": "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
      "media_type": "movie",
      "genre_ids": [
        18,
        80
      ],
      "popularity": 103.452,
      "release_date": "1972-03-14",
      "video": false,
      "vote_average": 8.706,
      "vote_count": 18655
    },
    {
      "adult": false,
      "backdrop_path": "/kGzFbGhp99zva6oZODW5atUtnqi.jpg",
      "id": 240,
      "title": "The Godfather Part II",
      "original_language": "en",
      "original_title": "The Godfather Part II",
      "overview": "In the continuing saga of the Corleone crime family, a young Vito Corleone grows up in Sicily and in 1910s New York. In the 1950s, Michael Corleone attempts to expand the family business into Las Vegas, Hollywood and Cuba.",
      "poster_path": "/hek3koDUyRQk7FIhPXsa6mT2Zc3.jpg",
      "media_type": "movie",
      "genre_ids": [
        18,
        80
      ],
      "popularity": 68.388,
      "release_date": "1974-12-20",
      "video": false,
      "vote_average": 8.59,
      "vote_count": 11276
    },
    {
      "adult": false,
      "backdrop_path": "/zNnjHLDtV8Ti3aworltaeaLMov4.jpg",
      "id": 242,
      "title": "The Godfather Part III",
      "original_language": "en",
      "original_title": "The Godfather Part III",
      "overview": "In the midst of trying to legitimize his business dealings in 1979 New York and Italy, aging mafia don, Michael Corleone seeks forgiveness for his sins while taking a young protege under his wing.",
      "poster_path": "/lm3pQ2QoQ16pextRsmnUbG2onES.jpg",
      "media_type": "movie",
      "genre_ids": [
        80,
        18,
        53
      ],
      "popularity": 55.353,
      "release_date": "1990-12-25",
      "video": false,
      "vote_average": 7.422,
      "vote_count": 5614
    }
  ]
}''';

final dummyRawMovieCollectionDetail = RawMovieCollectionDetail.fromJson(
    jsonDecode(dummyRawMovieCollectionDetailJson));

final MovieCollectionDetail dummyMovieCollectionDetail =
    dummyRawMovieCollectionDetail.toEntity();
