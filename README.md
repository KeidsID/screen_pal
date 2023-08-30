<h1 align="center"><b>
  Screen Pal
</b></h1>

[![codecov](https://codecov.io/github/KeidsID/screen_pal/graph/badge.svg?token=G20RM8PYOH)](https://codecov.io/github/KeidsID/screen_pal)
[![CD Web](https://github.com/KeidsID/screen_pal/actions/workflows/cd-web.yml/badge.svg)](https://github.com/KeidsID/screen_pal/actions/workflows/cd-web.yml)

<h3 align="center"><b>
  Discover Your Next Favorite Movie or Series from Your Pals
</b></h3>

<p align="center">
Screen Pal is a comprehensive movies and Series app that provides in-depth information about movies and Series from around the world. With a vast database of titles, users can easily search and browse for their next favorite show or movie. Each title comes with detailed information, such as the plot summary, cast and crew, ratings, and reviews. Users can also create watchlists and get personalized recommendations based on their viewing history.
</p>

<p align="center">
Screen Pal offers a user-friendly interface that makes it easy for users to find the information they need. The app is designed to cater to all kinds of viewers, from casual watchers to series and movie enthusiasts. Users can explore different genres, decades, and countries to find the titles that interest them.
</p>

<!-- <p align="center">
In addition to providing information about movies and Series, Screen Pal also offers the latest news and updates from the world of cinema and television. Users can stay up-to-date with the latest trailers, release dates, box office numbers, and Series premiere dates. The app also provides a list of popular movie theaters and showtimes in the user's area.
</p> -->

<p align="center">
Screen Pal is the ultimate app for anyone who loves movies and Series. With its extensive database, personalized recommendations, and up-to-date news, users can discover new titles and stay informed about their favorite movies and series.
</p>

Powered by <a href="https://www.themoviedb.org"> <img 
    src="assets/images/tmdb/alt-short.svg"
    alt="www.themoviedb.org"
    width="80px"
    height="10px"
  /> </a>.

## Dev Note

If you want to create your app, here are the requirements.

### Requirements

- `.env` file

  ```env
  IS_USE_PATH_URL_STRATEGY=bool
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
