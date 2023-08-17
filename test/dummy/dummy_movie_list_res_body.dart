import 'package:screen_pal/infrastructures/api/models/movie_list_res_body.dart';

const dummyRawMovieListResBody = '''{
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

final dummyMovieListResBody =
    MovieListResBody.fromJson(dummyRawMovieListResBody);
