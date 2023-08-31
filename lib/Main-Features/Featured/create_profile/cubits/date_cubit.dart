import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class DatingCubit extends Cubit<DateTime?> {
  DatingCubit() : super(null);

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      emit(pickedDate);
    }
  }
}
