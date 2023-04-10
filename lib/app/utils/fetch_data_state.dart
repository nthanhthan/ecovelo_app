import 'package:equatable/equatable.dart';

class FetchDataState extends Equatable {
  const FetchDataState();

  @override
  List<Object> get props => [];
}

class FetchDataError extends FetchDataState {}
class FetchDataProcessing extends FetchDataState {}
class FetchDataReady extends FetchDataState {}
class FetchDataEmpty extends FetchDataState {}