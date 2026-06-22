import 'package:equatable/equatable.dart';

abstract class SewaverseEvent extends Equatable {
  const SewaverseEvent();

  @override
  List<Object?> get props => [];
}
class LoadServices extends SewaverseEvent {
  const LoadServices();
}