import 'dart:convert';

import 'package:screen_pal/infrastructures/api/models/tv_shows/tv_show_list_res_body.dart';

const dummyTvShowListResBodyJson = '''
{
  "page": 1,
  "results": [
    {
      "backdrop_path": "/3n2TjKw3HrwDqgVgcynvantOfS3.jpg",
      "first_air_date": "2023-01-04",
      "genre_ids": [
        18,
        10751
      ],
      "id": 215103,
      "name": "Teri Meri Doriyaann",
      "origin_country": [
        "IN"
      ],
      "original_language": "hi",
      "original_name": "तेरी मेरी डोरियाँ",
      "overview": "It’s hate at first sight for Sahiba and Angad! But destined to be together, their lives get intertwined by a marriage alliance, and a love-hate story ensues.",
      "popularity": 3103.841,
      "poster_path": "/4BHDmYiuSnNL3nqKIOzLJKYX4AN.jpg",
      "vote_average": 7.2,
      "vote_count": 110
    }
  ],
  "total_pages": 1,
  "total_results": 1
}
''';

/// Refer to [dummyTvShowListResBodyJson] for the props values.
final dummyTvShowListResBody =
    TvShowListResBody.fromJson(jsonDecode(dummyTvShowListResBodyJson));

/// Refer to [dummyTvShowListResBodyJson] for the props values.
final dummyTvShow = dummyTvShowListResBody.results.first.toEntity();
