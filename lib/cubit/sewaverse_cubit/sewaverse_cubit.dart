import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/sewaverse_cubit/sewaverse_state_cubit.dart';
import 'package:todo_app/data/repository/sewaverse_home_repo/sewaverse_repo.dart';

class SewaverseCubit extends Cubit<SewaverseStateCubit>{
  final SewaverseRepo repo;
  SewaverseCubit(this.repo) : super(CubitInitialState());

  Future<void> getService()  async {
    emit(CubitLoadingState());
    try{
      final response = await repo.getServices();
      emit(CubitLoadedState(response));
    } catch (e){
      emit(CubitErrorState(errorMessage: e.toString()));
    }
  }
}