import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/sewaverse_home/sewaverse_event.dart';
import 'package:todo_app/bloc/sewaverse_home/sewaverse_state.dart';

import '../../data/repository/sewaverse_home_repo/sewaverse_repo.dart';

class SewaverseBloc extends Bloc<SewaverseEvent, SewaverseState>{

  final SewaverseRepo repository;

  SewaverseBloc(this.repository) : super(InitialState()){
    on<LoadServices>((event, emit) async {
      emit(LoadingState());
      try{
          final response = await repository.getServices();

          emit(LoadedState(response));
      }catch (e) {
        emit(ErrorState(e.toString()));
      }
    }
    );
  }

}