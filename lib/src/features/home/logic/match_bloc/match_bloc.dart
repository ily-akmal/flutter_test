import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/match_api_service.dart';
import 'match_event.dart';
import 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final MatchApiService _matchApiService;

  MatchBloc(this._matchApiService) : super(MatchInitial()) {
    on<FetchMatches>((event, emit) async {
      emit(MatchLoading());
      try {
        final matches = await _matchApiService.fetchMatches();
        emit(MatchLoaded(matches));
      } catch (e) {
        emit(MatchError(e.toString()));
      }
    });
  }
}
