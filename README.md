<h1 align="center"><b>
  Screen Pal
</b></h1>

[![codecov](https://codecov.io/github/KeidsID/screen_pal/graph/badge.svg?token=G20RM8PYOH)](https://codecov.io/github/KeidsID/screen_pal)
[![CD Web](https://github.com/KeidsID/screen_pal/actions/workflows/cd-web.yml/badge.svg)](https://github.com/KeidsID/screen_pal/actions/workflows/cd-web.yml)

<h3 align="center"><b>
  Discover Your Next Favorite Movies or TV Shows from Your Best Pal
</b></h3>

<p align="center">
Screen Pal an app that provides in-depth information about movies and TV shows. With its massive database, users can easily search for their next favorite movies or TV shows. Each search result will provide a plot summary, release date, genre, and more.
</p>

<p align="center">
Screen Pal offers a user-friendly interface that makes it easy for users to find the information they need. The app is designed to serve all types of viewers, from casual viewers to fans of movies and TV shows. Users can explore different genres and countries to find titles that interest them.
</p>

Powered by <a href="https://www.themoviedb.org"> <img 
    src="assets/images/tmdb/alt-short.svg"
    alt="www.themoviedb.org"
    width="80px"
    height="10px"
  /> </a>.

## Dev Note

Want to contribute? here are the requirements to run it.

### Requirements

- `.env` file

  ```env
  IS_USE_PATH_URL_STRATEGY=<bool (optional/default: true)>
  TMDB_ACC_TOKEN=<your own tmdb acc token>
  ```

  - `IS_USE_PATH_URL_STRATEGY` details

    What is the `path URL strategy`? So web routing in Flutter by default will
    be preceded by a hash (#), so the URL will be like this:
    `your-domain.com/#/path`. So if we use the `path URL strategy`, then the URL
    will be without a hash like a web in general.

    Why does this env exist? Because some hosting services do not have the
    "rewrite and redirect" configuration (Github Pages, AWS S3, etc.). So "path
    URL strategy" only works on Flutter (App navigation works, even updating the
    URL), but not on the host server (can't navigate on browser nav bar).

    Refs:

    - [PathUrlStrategy needs better docs (expected server behavior)](https://github.com/flutter/flutter/issues/89763)

- run this command to generate the required files
  ```sh
  flutter pub get
  dart run build_runner build --delete-conflicting-outputs
  ```
