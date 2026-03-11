
import 'package:bloc/bloc.dart';

import '../../../data/repository/sewa_repo/sewaverse_repo.dart';
import 'sewa_event.dart';
import 'sewa_state.dart';

class SewaBloc extends Bloc<SewaEvent, SewaState> {
  final SewaverseRepository repository;

  SewaBloc({required this.repository}) : super(SewaInitial()) {
    on<FetchSewaEvent>((event, emit) async {
      emit(SewaLoading());

      try {
        await Future.delayed(const Duration(seconds: 5));
        final data = await repository.fetchData(); // returns SewaverseModel
        emit(SewaLoaded(data));
      } catch (e) {
        emit(SewaError(e.toString()));
      }
    });
  }
}