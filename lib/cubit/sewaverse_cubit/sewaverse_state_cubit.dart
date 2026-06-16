import 'package:todo_app/domain/models/sewa_model/sewaverse_model.dart';

abstract class SewaverseStateCubit {}

class CubitInitialState extends SewaverseStateCubit{}

class CubitLoadingState extends SewaverseStateCubit{}


class CubitLoadedState extends SewaverseStateCubit{

  final SewaverseModel sewaverse;
  CubitLoadedState(this.sewaverse);

}

class CubitErrorState extends SewaverseStateCubit{
  final String errorMessage;
  CubitErrorState({required this.errorMessage});
}