import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:screen_pal/core/entities/movie.dart';
import 'package:screen_pal/infrastructures/api/tmdb_dio.dart';
import 'package:screen_pal/interfaces/providers/movie/movie_list_providers.dart';
import 'package:screen_pal/interfaces/widgets/card/movie_card.dart';
import 'package:screen_pal/interfaces/widgets/default_network_image.dart';
import 'package:screen_pal/interfaces/widgets/errors/dio_exception_page.dart';

part 'mobile_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MobileLayout();
  }
}

void _navigateToMovieDetail(BuildContext context, int movieId) {
  context.go('/movies/movie-$movieId');
}

Widget _providerErrorHandler(Object err, StackTrace stackTrace) {
  if (err is! DioException) {
    debugPrint('$err');

    return Center(
      child: Text('${err.runtimeType}'),
    );
  }

  return DioExceptionPage(exception: err);
}

Widget _providerLoadingHandler() {
  return const Center(child: CircularProgressIndicator());
}
