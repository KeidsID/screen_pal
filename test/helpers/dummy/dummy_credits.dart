import 'dart:convert';

import 'package:screen_pal/infrastructures/api/models/credits/raw_credits.dart';

const dummyRawMovieCreditsJson = '''{
  "id": 609681,
  "cast": [
    {
      "adult": false,
      "gender": 1,
      "id": 60073,
      "known_for_department": "Acting",
      "name": "Brie Larson",
      "original_name": "Brie Larson",
      "popularity": 60.762,
      "profile_path": "/iqZ5uKJWbwSITCK4CqdlUHZTnXD.jpg",
      "cast_id": 1,
      "character": "Carol Danvers / Captain Marvel",
      "credit_id": "5d08fd3bc3a3687c751ef54c",
      "order": 0
    },
    {
      "adult": false,
      "gender": 1,
      "id": 970219,
      "known_for_department": "Acting",
      "name": "Teyonah Parris",
      "original_name": "Teyonah Parris",
      "popularity": 22.193,
      "profile_path": "/k3U24YNgdaINZEQ4PftebnN5cpU.jpg",
      "cast_id": 15,
      "character": "Monica Rambeau",
      "credit_id": "5fd2c387fea0d7003c840847",
      "order": 1
    },
    {
      "adult": false,
      "gender": 1,
      "id": 2798462,
      "known_for_department": "Acting",
      "name": "Iman Vellani",
      "original_name": "Iman Vellani",
      "popularity": 55.399,
      "profile_path": "/uqaJuR24yXL1oXvAqUbOoEGChgb.jpg",
      "cast_id": 14,
      "character": "Kamala Khan / Ms. Marvel",
      "credit_id": "5fd2c34c1d3143003c47b952",
      "order": 2
    }
  ],
  "crew": [
    {
      "adult": false,
      "gender": 1,
      "id": 7232,
      "known_for_department": "Production",
      "name": "Sarah Halley Finn",
      "original_name": "Sarah Halley Finn",
      "popularity": 6.565,
      "profile_path": "/jxECVz09YGZAg1AmdzfEkPm4xeY.jpg",
      "credit_id": "5f2c41e1f1759c00378c8b6f",
      "department": "Production",
      "job": "Casting"
    },
    {
      "adult": false,
      "gender": 2,
      "id": 10850,
      "known_for_department": "Production",
      "name": "Kevin Feige",
      "original_name": "Kevin Feige",
      "popularity": 14.842,
      "profile_path": "/kCBqXZ5PT5udYGEj2wfTSFbLMvT.jpg",
      "credit_id": "5d08fe1592514135eab93467",
      "department": "Production",
      "job": "Producer"
    },
    {
      "adult": false,
      "gender": 2,
      "id": 24192,
      "known_for_department": "Sound",
      "name": "Dave Jordan",
      "original_name": "Dave Jordan",
      "popularity": 2.051,
      "profile_path": null,
      "credit_id": "64b8bac825882300ae635b22",
      "department": "Sound",
      "job": "Music Supervisor"
    }
  ]
}''';

final dummyRawMovieCredits =
    RawCredits.fromJson(jsonDecode(dummyRawMovieCreditsJson));

final dummyMovieCredits = dummyRawMovieCredits.toEntity();

const dummyRawTvShowCreditsJson = '''{
  "cast": [
    {
      "adult": false,
      "gender": 2,
      "id": 91606,
      "known_for_department": "Acting",
      "name": "Tom Hiddleston",
      "original_name": "Tom Hiddleston",
      "popularity": 40.717,
      "profile_path": "/mclHxMm8aPlCPKptP67257F5GPo.jpg",
      "character": "Loki Laufeyson",
      "credit_id": "5c3b1ea19251414deb754b4b",
      "order": 0
    },
    {
      "adult": false,
      "gender": 1,
      "id": 1252533,
      "known_for_department": "Acting",
      "name": "Sophia Di Martino",
      "original_name": "Sophia Di Martino",
      "popularity": 62.798,
      "profile_path": "/qZdFp18btpQJfDoknxr7DgfRpcB.jpg",
      "character": "Sylvie / The Variant",
      "credit_id": "5dcf5f5ccc277c0017e6905d",
      "order": 1
    },
    {
      "adult": false,
      "gender": 1,
      "id": 134774,
      "known_for_department": "Acting",
      "name": "Wunmi Mosaku",
      "original_name": "Wunmi Mosaku",
      "popularity": 26.069,
      "profile_path": "/mWDsVCo9sBcekrsjUTsoCFLhtYt.jpg",
      "character": "Hunter B-15",
      "credit_id": "5fd65c5ec995ee003e506bd6",
      "order": 3
    }
  ],
  "crew": [
    {
      "adult": false,
      "gender": 2,
      "id": 1074560,
      "known_for_department": "Writing",
      "name": "Justin Benson",
      "original_name": "Justin Benson",
      "popularity": 5.83,
      "profile_path": "/mch4MNcOxVsej3O5ifugkZTFzWI.jpg",
      "credit_id": "6464043e0f365500fce02ce7",
      "department": "Production",
      "job": "Executive Producer"
    },
    {
      "adult": false,
      "gender": 2,
      "id": 583479,
      "known_for_department": "Directing",
      "name": "Aaron Moorhead",
      "original_name": "Aaron Moorhead",
      "popularity": 11.227,
      "profile_path": "/plvZ27ya8yxyyqSCHbwBMjFfJwS.jpg",
      "credit_id": "646404447e348300e36a0aac",
      "department": "Production",
      "job": "Executive Producer"
    },
    {
      "adult": false,
      "gender": 2,
      "id": 3119335,
      "known_for_department": "Writing",
      "name": "Eric Martin",
      "original_name": "Eric Martin",
      "popularity": 5.373,
      "profile_path": null,
      "credit_id": "646404647e3483011a512af7",
      "department": "Production",
      "job": "Executive Producer"
    }
  ],
  "id": 84958
}''';

final dummyRawTvShowCredits =
    RawCredits.fromJson(jsonDecode(dummyRawTvShowCreditsJson));

final dummyTvShowCredits = dummyRawTvShowCredits.toEntity();
