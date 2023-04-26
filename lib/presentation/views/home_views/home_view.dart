import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularsMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final isLoadig = ref.watch(initialLoadingProvider);
    if (isLoadig) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularsMovies = ref.watch(popularsMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          title: CustomAppbar(),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (context, index) {
            return Column(
              children: [
                // const CustomAppbar(),
                MoviesSlideshow(
                  movies: moviesSlideshow,
                ),
                MoviesHorizontalListview(
                  movie: nowPlayingMovies,
                  title: 'En Cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movie: popularsMovies,
                  title: 'Populares',
                  // subTitle: 'Lunes 20',
                  loadNextPage: () =>
                      ref.read(popularsMoviesProvider.notifier).loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movie: upcomingMovies,
                  title: 'Proximamente',
                  subTitle: 'En este mes',
                  loadNextPage: () =>
                      ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movie: topRatedMovies,
                  title: 'Mejor Calificadas',
                  subTitle: '2023',
                  loadNextPage: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      )
    ]);
  }
}
