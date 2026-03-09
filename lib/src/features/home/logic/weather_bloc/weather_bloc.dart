import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/weather_api_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherApiService _weatherApiService;

  WeatherBloc(this._weatherApiService) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await _weatherApiService.fetchWeather();
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError(e.toString()));
      }
    });
  }
}
