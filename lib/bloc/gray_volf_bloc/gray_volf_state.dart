import 'package:todo_app/domain/models/gray_volf_model/job_type_model.dart';

abstract class GrayVolfState {}

class InitialState extends GrayVolfState{}

class LoadingState extends GrayVolfState{}
class LoadedState extends GrayVolfState {
  final List<JobModel> jobs;

  LoadedState({
    required this.jobs,
  });
}
class ErrorState extends GrayVolfState{
  final String message;
  ErrorState({
    required this.message
});
}


class WishListState extends GrayVolfState{
  bool isWishList;
  WishListState({
    required this.isWishList
});
}