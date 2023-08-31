import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class TimeCubit extends Cubit<TimeOfDay?> {
  TimeCubit() : super(null);

  void selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(initialTime: TimeOfDay.now(), context: context);

    if (pickedTime != null) {
      emit(pickedTime);
    }
  }
}
