
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/gray_volf_bloc/gray_volf_event.dart';
import 'package:todo_app/bloc/gray_volf_bloc/gray_volf_state.dart';
import 'package:todo_app/data/repository/gray_volf_repo/job_types_repo.dart';

class GrayVolfBloc extends Bloc<GrayVolfEvent ,GrayVolfState>{
  final JobTypesRepo _repo;

  GrayVolfBloc(this._repo) : super(InitialState()){
    on<GetJobEvent>((event, emit) async {
        emit(LoadingState());

      try{
        final jobType = await _repo.getJob();
        emit(LoadedState(jobs: jobType));
      } catch (e){
        emit(ErrorState(
          message: e.toString()
        ));
      }
    });

  }
}