// Define the state classes
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DoubleMatchState {}

class DoubleMatchInitial extends DoubleMatchState {}

class DoubleMatchInProgress extends DoubleMatchState {}

class DoubleMatchSuccess extends DoubleMatchState {}

class DoubleMatchFailure extends DoubleMatchState {
  final String error;
  DoubleMatchFailure({required this.error});
}
