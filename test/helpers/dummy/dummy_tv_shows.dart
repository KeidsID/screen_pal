import 'dart:convert';

import 'package:screen_pal/infrastructures/tmdb/models/tv_shows/raw_tv_show_detail.dart';
import 'package:screen_pal/infrastructures/tmdb/models/tv_shows/tv_show_list_res_body.dart';

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

const dummyRawTvShowDetailJson = r'''
{
  "adult": false,
  "backdrop_path": "/q3jHCb4dMfYF6ojikKuHd6LscxC.jpg",
  "created_by": [
    {
      "id": 2094567,
      "credit_id": "6001713e7390c0003df730af",
      "name": "Michael Waldron",
      "gender": 2,
      "profile_path": "/5d6wkYnJgkVAzThqnnwOLNDzACM.jpg"
    }
  ],
  "episode_run_time": [
    52
  ],
  "first_air_date": "2021-06-09",
  "genres": [
    {
      "id": 18,
      "name": "Drama"
    },
    {
      "id": 10765,
      "name": "Sci-Fi & Fantasy"
    }
  ],
  "homepage": "https://www.disneyplus.com/series/wp/6pARMvILBGzF",
  "id": 84958,
  "in_production": true,
  "languages": [
    "en"
  ],
  "last_air_date": "2023-10-19",
  "last_episode_to_air": {
    "id": 4447780,
    "name": "1893",
    "overview": "Loki & Mobius go on the hunt to find everyone’s favorite cartoon clock as they try to save the TVA.",
    "vote_average": 6.895,
    "vote_count": 19,
    "air_date": "2023-10-19",
    "episode_number": 3,
    "episode_type": "standard",
    "production_code": "",
    "runtime": 56,
    "season_number": 2,
    "show_id": 84958,
    "still_path": "/pwAniwa715V556WQSmoJiOvTchW.jpg"
  },
  "name": "Loki",
  "next_episode_to_air": {
    "id": 4447781,
    "name": "Episode 4",
    "overview": "",
    "vote_average": 5.5,
    "vote_count": 2,
    "air_date": "2023-10-26",
    "episode_number": 4,
    "episode_type": "standard",
    "production_code": "",
    "runtime": null,
    "season_number": 2,
    "show_id": 84958,
    "still_path": "/4BqPWUCsyaf8LCMEjduvdLaF78c.jpg"
  },
  "networks": [
    {
      "id": 2739,
      "logo_path": "/uzKjVDmQ1WRMvGBb7UNRE0wTn1H.png",
      "name": "Disney+",
      "origin_country": ""
    }
  ],
  "number_of_episodes": 12,
  "number_of_seasons": 2,
  "origin_country": [
    "US"
  ],
  "original_language": "en",
  "original_name": "Loki",
  "overview": "After stealing the Tesseract during the events of “Avengers: Endgame,” an alternate version of Loki is brought to the mysterious Time Variance Authority, a bureaucratic organization that exists outside of time and space and monitors the timeline. They give Loki a choice: face being erased from existence due to being a “time variant” or help fix the timeline and stop a greater threat.",
  "popularity": 1724.625,
  "poster_path": "/voHUmluYmKyleFkTu3lOXQG702u.jpg",
  "production_companies": [
    {
      "id": 420,
      "logo_path": "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png",
      "name": "Marvel Studios",
      "origin_country": "US"
    },
    {
      "id": 176762,
      "logo_path": null,
      "name": "Kevin Feige Productions",
      "origin_country": "US"
    }
  ],
  "production_countries": [
    {
      "iso_3166_1": "US",
      "name": "United States of America"
    }
  ],
  "seasons": [
    {
      "air_date": "2021-06-09",
      "episode_count": 6,
      "id": 114355,
      "name": "Season 1",
      "overview": "Loki, the God of Mischief, steps out of his brother's shadow to embark on an adventure that takes place after the events of \"Avengers: Endgame.\"",
      "poster_path": "/8uVqe9ThcuYVNdh4O0kuijIWMLL.jpg",
      "season_number": 1,
      "vote_average": 7.8
    },
    {
      "air_date": "2023-10-05",
      "episode_count": 6,
      "id": 341180,
      "name": "Season 2",
      "overview": "In the aftermath of Season 1, Loki finds himself in a battle for the soul of the Time Variance Authority. Along with Mobius, Hunter B-15 and a team of new and returning characters, Loki navigates an ever-expanding and increasingly dangerous multiverse in search of Sylvie, Judge Renslayer, Miss Minutes and the truth of what it means to possess free will and glorious purpose.",
      "poster_path": "/8vjTn0NGF5vM8BijlJxe6YZCRmU.jpg",
      "season_number": 2,
      "vote_average": 6.9
    }
  ],
  "spoken_languages": [
    {
      "english_name": "English",
      "iso_639_1": "en",
      "name": "English"
    }
  ],
  "status": "Returning Series",
  "tagline": "Loki's time has come.",
  "type": "Scripted",
  "vote_average": 8.164,
  "vote_count": 10357
}
''';

/// Refer to [dummyRawTvShowDetailJson] for the props values.
final dummyRawTvShowDetail =
    RawTvShowDetail.fromJson(jsonDecode(dummyRawTvShowDetailJson));

/// Refer to [dummyRawTvShowDetailJson] for the props values.
final dummyTvShowDetail = dummyRawTvShowDetail.toEntity();
