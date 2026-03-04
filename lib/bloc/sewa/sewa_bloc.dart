import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/sewa_repositories.dart';
import 'sewa_event.dart';
import 'sewa_state.dart';

class SewaBloc extends Bloc<SewaEvent, SewaState> {
  final SewaRepositories repository;

  SewaBloc({required this.repository}) : super(SewaInitial()) {
    // When FetchSewaData event is added
    on<FetchSewaEvent>((event, emit) async {
      emit(SewaLoading());

      try {
        final data = await repository.fetchData(); // List<Data>
        emit(SewaLoaded(data)); // ✅ matches type
      } catch (e) {
        emit(SewaError(e.toString()));
      }
    });
  }
}