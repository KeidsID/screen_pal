import 'dart:convert';

import 'package:screen_pal/infrastructures/tmdb/models/credits/raw_tv_credits.dart';

const dummyRawTvCreditsJson = '''{
  "cast": [
    {
      "adult": false,
      "gender": 2,
      "id": 4691,
      "known_for_department": "Acting",
      "name": "James Gandolfini",
      "original_name": "James Gandolfini",
      "popularity": 17.807,
      "profile_path": "/vhtsFJZcfHdeDkFBoWMDzOS6xrP.jpg",
      "roles": [
        {
          "credit_id": "5256c88b19c2956ff604659e",
          "character": "Tony Soprano",
          "episode_count": 86
        }
      ],
      "total_episode_count": 86,
      "order": 0
    },
    {
      "adult": false,
      "gender": 1,
      "id": 36190,
      "known_for_department": "Acting",
      "name": "Edie Falco",
      "original_name": "Edie Falco",
      "popularity": 13.636,
      "profile_path": "/jS2Hnr5OmntpX0J7EpH70zAG0mz.jpg",
      "roles": [
        {
          "credit_id": "5256c88b19c2956ff60465e6",
          "character": "Carmela Soprano",
          "episode_count": 86
        }
      ],
      "total_episode_count": 86,
      "order": 1
    },
    {
      "adult": false,
      "gender": 1,
      "id": 99241,
      "known_for_department": "Acting",
      "name": "Jamie-Lynn Sigler",
      "original_name": "Jamie-Lynn Sigler",
      "popularity": 21.164,
      "profile_path": "/gzlpJeYY1ByXOGb6mksEzuvetTN.jpg",
      "roles": [
        {
          "credit_id": "5256c88a19c2956ff604647c",
          "character": "Meadow Soprano",
          "episode_count": 86
        }
      ],
      "total_episode_count": 86,
      "order": 2
    }
  ],
  "crew": [
    {
      "adult": false,
      "gender": 2,
      "id": 1430231,
      "known_for_department": "Art",
      "name": "Bob Shaw",
      "original_name": "Bob Shaw",
      "popularity": 1.016,
      "profile_path": null,
      "jobs": [
        {
          "credit_id": "55f57df5c3a3686d180059dd",
          "job": "Production Design",
          "episode_count": 73
        }
      ],
      "department": "Art",
      "total_episode_count": 73
    },
    {
      "adult": false,
      "gender": 0,
      "id": 1473156,
      "known_for_department": "Art",
      "name": "Dean Taucher",
      "original_name": "Dean Taucher",
      "popularity": 1.55,
      "profile_path": null,
      "jobs": [
        {
          "credit_id": "55f0b0b39251412c45000158",
          "job": "Production Design",
          "episode_count": 12
        }
      ],
      "department": "Art",
      "total_episode_count": 12
    },
    {
      "adult": false,
      "gender": 0,
      "id": 1507718,
      "known_for_department": "Art",
      "name": "Diann Duthie",
      "original_name": "Diann Duthie",
      "popularity": 0.694,
      "profile_path": null,
      "jobs": [
        {
          "credit_id": "55f0b1599251412c3c000163",
          "job": "Art Direction",
          "episode_count": 1
        }
      ],
      "department": "Art",
      "total_episode_count": 1
    }
  ],
  "id": 1398
}''';

final dummyRawTvShowCredits =
    RawTvCredits.fromJson(jsonDecode(dummyRawTvCreditsJson));
final dummyTvShowCredits = dummyRawTvShowCredits.toEntity();
