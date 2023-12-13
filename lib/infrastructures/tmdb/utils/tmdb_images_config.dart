// coverage:ignore-file

/// This library contain images config for [TMDB](https://www.themoviedb.org) API.
///
/// TMDB API only response image path.
/// ```json
/// {
///   "backdrop_path": "/image-path.png",
///   "logo_path": "/image-path.png",
///   "poster_path": "/image-path.png",
///   "profile_path": "/image-path.png",
///   "still_path": "/image-path.png"
/// }
/// ```
///
/// The format to fetch image is: `<base-url-for-image><size><path>`.
///
/// - `<base-url-for-image>` -> its either [tmdbImageBaseUrl] or
///   [tmdbImageSecureBaseUrl].
///
/// - `<size>` -> based on image type.
///   - [TmdbBackdropImageSizes] for "backdrop_path",
///   - [TmdbLogoImageSizes] for "logo_path",
///   - [TmdbPosterImageSizes] for "poster_path",
///   - [TmdbProfileImageSizes] for "profile_path",
///   - [TmdbStillImageSizes] for "still_path".
///
/// - `<path>` -> the path value from response.
///
/// Take for example the Netflix logo (wwemzKWzjKYJFfCeiB57q3r4Bcm.svg), you can
/// call one of the following:
/// ```
/// https://image.tmdb.org/t/p/original/wwemzKWzjKYJFfCeiB57q3r4Bcm.svg
/// https://image.tmdb.org/t/p/w45/wwemzKWzjKYJFfCeiB57q3r4Bcm.svg
/// https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.svg
/// ```
///
/// To get a url like the example above, you can do it with the help of enum mixin:
/// ```
/// TmdbLogoImageSizes.original.secureFetchUrl('/wwemzKWzjKYJFfCeiB57q3r4Bcm.svg');
/// TmdbLogoImageSizes.w45.secureFetchUrl('/wwemzKWzjKYJFfCeiB57q3r4Bcm.svg');
/// TmdbLogoImageSizes.w500.secureFetchUrl('/wwemzKWzjKYJFfCeiB57q3r4Bcm.svg');
/// ```
///
/// Refs:
///
/// - [Config source](https://developer.themoviedb.org/reference/configuration-details).
library tmdb_images_config;

import 'package:flutter/foundation.dart';

/// TMDB Base url to fetch image.
const tmdbImageBaseUrl = 'http://image.tmdb.org/t/p/';

/// Secure version of [tmdbImageBaseUrl].
const tmdbImageSecureBaseUrl = 'https://image.tmdb.org/t/p/';

@protected
mixin TmdbImageSizesMixin on Enum {
  /// Url to fetch image. Return null if not valid path (start with `/`).
  String? fetchUrl(String? path) {
    if (path == null || !path.startsWith('/')) return null;

    return "$tmdbImageBaseUrl$name$path";
  }

  /// Secure version of [fetchUrl].
  String? secureFetchUrl(String? path) {
    if (path == null || !path.startsWith('/')) return null;

    return '$tmdbImageSecureBaseUrl$name$path';
  }
}

/// Sizes for backdrop image.
enum TmdbBackdropImageSizes with TmdbImageSizesMixin {
  w300,
  w780,
  w1280,
  original,
}

/// Sizes for logo image.
enum TmdbLogoImageSizes with TmdbImageSizesMixin {
  w45,
  w92,
  w154,
  w185,
  w300,
  w500,
  original,
}

/// Sizes for poster image.
enum TmdbPosterImageSizes with TmdbImageSizesMixin {
  w92,
  w154,
  w185,
  w342,
  w500,
  w780,
  original,
}

/// Sizes for profile image.
enum TmdbProfileImageSizes with TmdbImageSizesMixin {
  w45,
  w185,
  h632,
  original,
}

/// Sizes for still image.
enum TmdbStillImageSizes with TmdbImageSizesMixin { w92, w185, w300, original }
