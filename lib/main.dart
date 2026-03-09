import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/core/network/dio_client.dart';
import 'src/features/home/data/services/match_api_service.dart';
import 'src/features/home/data/services/weather_api_service.dart';

import 'src/features/home/logic/match_bloc/match_bloc.dart';
import 'src/features/home/logic/match_bloc/match_event.dart';
import 'src/features/home/logic/weather_bloc/weather_bloc.dart';
import 'src/features/home/logic/weather_bloc/weather_event.dart';

import 'src/features/home/presentation/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Dependency Injection Setup
  final dioClient = DioClient().dio;
  final weatherApiService = WeatherApiService(dioClient);
  final matchApiService = MatchApiService(dioClient);

  runApp(
    MyApp(
      weatherApiService: weatherApiService,
      matchApiService: matchApiService,
    ),
  );
}

class MyApp extends StatelessWidget {
  final WeatherApiService weatherApiService;
  final MatchApiService matchApiService;

  const MyApp({
    super.key,
    required this.weatherApiService,
    required this.matchApiService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) =>
              WeatherBloc(weatherApiService)..add(FetchWeather()),
        ),
        BlocProvider<MatchBloc>(
          create: (context) => MatchBloc(matchApiService)..add(FetchMatches()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter BLoC Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const HomeScreen(),
      ),
    );
  }
}
