part of 'movies_home_page.dart';

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final screenSize = MediaQuery.of(context).size;

    const sectionHeight = 240.0;
    const contentWidth = 160.0;

    List<Widget> section({
      required String title,
      required AutoDisposeFutureProvider<List<Movie>> moviesProvider,
    }) {
      return [
        Text(title, style: textTheme.titleLarge),
        SizedBox(
          height: sectionHeight,
          child: Consumer(builder: (_, ref, __) {
            final movieListProvider = ref.watch(moviesProvider);

            return movieListProvider.when(
              data: (movies) {
                return _MovieListViewHoriz(
                  movies: movies,
                  itemWidth: contentWidth,
                );
              },
              error: _providerErrorHandler,
              loading: _providerLoadingHandler,
            );
          }),
        ),
      ];
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MoviesCarousel(
                moviesProvider: popularMoviesProvider,
                height: screenSize.height * 0.6,
              ),
              const SizedBox(height: 16.0),
              ...section(
                title: 'On Theatres',
                moviesProvider: nowPlayingMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              ...section(
                title: 'Top Rated',
                moviesProvider: topRatedMoviesProvider,
              ),
              const SizedBox(height: 16.0),
              ...section(
                title: 'Coming Soon',
                moviesProvider: upcomingMoviesProvider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoviesCarousel extends StatelessWidget {
  const _MoviesCarousel({
    required this.moviesProvider,
    this.height,
  });

  final AutoDisposeFutureProvider<List<Movie>> moviesProvider;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SizedBox(
      height: height,
      child: Consumer(
        builder: (_, ref, __) {
          final movieListProvider = ref.watch(moviesProvider);

          return movieListProvider.when(
            data: (movies) => CarouselSlider.builder(
              options: CarouselOptions(
                height: height,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 6),
                autoPlayAnimationDuration: const Duration(seconds: 2),
              ),
              itemCount: movies.length,
              itemBuilder: (context, index, realIndex) {
                final movie = movies[index];

                return InkWell(
                  onTap: () => _navigateToMovieDetail(context, movie.id),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    fit: StackFit.expand,
                    children: [
                      DefaultNetworkImage(
                        imageUrl: '$tmdbImageBaseUrl${movie.backdropPath}',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.scaffoldBackgroundColor,
                              theme.scaffoldBackgroundColor.withOpacity(0.1),
                              Colors.transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              movie.title,
                              style: textTheme.headlineLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              [
                                movie.releaseDate.year,
                                '${movie.voteAverage * 10}%'
                              ].join(' • '),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            error: _providerErrorHandler,
            loading: _providerLoadingHandler,
          );
        },
      ),
    );
  }
}

class _MovieListViewHoriz extends StatelessWidget {
  const _MovieListViewHoriz({required this.movies, this.itemWidth});

  final List<Movie> movies;
  final double? itemWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (_, index) {
        final movie = movies[index];

        return SizedBox(
          width: itemWidth,
          child: MovieCard(
            movie: movie,
            onTap: () => context.go('/movies/movie-${movie.id}'),
          ),
        );
      },
    );
  }
}
