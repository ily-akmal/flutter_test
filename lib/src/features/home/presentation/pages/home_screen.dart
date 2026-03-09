import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/weather_bloc/weather_bloc.dart';
import '../../logic/weather_bloc/weather_state.dart';
import '../../logic/match_bloc/match_bloc.dart';
import '../../logic/match_bloc/match_state.dart';

import '../widgets/weather_card.dart';
import '../widgets/match_tile.dart';
import '../../data/models/match_model.dart';
import '../../../../shared/widgets/custom_shimmer.dart';
import '../../../../shared/widgets/custom_circular_loader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: CustomScrollView(
        slivers: [
          // Weather Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const CustomShimmer(
                      width: double.infinity,
                      height: 120,
                      borderRadius: 16,
                    );
                  } else if (state is WeatherLoaded) {
                    return WeatherCard(weather: state.weather);
                  } else if (state is WeatherError) {
                    return Card(
                      color: Colors.red[50],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Weather Error: ${state.message}'),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),

          // Matches Section
          BlocBuilder<MatchBloc, MatchState>(
            builder: (context, state) {
              if (state is MatchLoading) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(48.0),
                    child: CustomCircularLoader(size: 40),
                  ),
                );
              } else if (state is MatchLoaded) {
                if (state.matches.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text('No matches available.'),
                      ),
                    ),
                  );
                }

                final liveMatches = state.matches
                    .where((m) => m.isLive)
                    .toList();
                final upcomingMatches = state.matches
                    .where((m) => m.isUpcoming)
                    .toList();
                final recentMatches = state.matches
                    .where((m) => !m.isLive && !m.isUpcoming)
                    .take(8)
                    .toList();

                return SliverMainAxisGroup(
                  slivers: [
                    if (liveMatches.isNotEmpty)
                      _buildMatchSection('Live Matches', liveMatches),
                    if (upcomingMatches.isNotEmpty)
                      _buildMatchSection('Upcoming Matches', upcomingMatches),
                    if (recentMatches.isNotEmpty)
                      _buildMatchSection('Recent Matches', recentMatches),
                  ],
                );
              } else if (state is MatchError) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Matches Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildMatchSection(String title, List<MatchModel> matches) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return MatchTile(match: matches[index]);
          }, childCount: matches.length),
        ),
      ],
    );
  }
}
