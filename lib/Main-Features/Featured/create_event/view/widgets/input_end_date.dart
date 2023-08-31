import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../generated/l10n.dart';

class EndDateTimeCubit extends Cubit<DateTime> {
  EndDateTimeCubit() : super(DateTime.now());

  void selectDateTime(DateTime dateTime) {
    emit(dateTime);
  }
}

class InputEndDateAndTime extends StatefulWidget {
  final String text;
  final String hint;
  final String format;
  final Null Function(DateTime dateTime) onDateTimeSelected;

  const InputEndDateAndTime({
    Key? key,
    required this.text,
    required this.hint,
    this.format = 'MMM d, yyyy',
    required this.onDateTimeSelected,
  }) : super(key: key);

  @override
  _InputEndDateAndTimeState createState() => _InputEndDateAndTimeState();
}

class _InputEndDateAndTimeState extends State<InputEndDateAndTime> {
  late DateTime _selectedDateTime;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = context.read<EndDateTimeCubit>().state;
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _selectedTime = pickedTime;
        });

        // Use the cubit to update the selected date and time
        context.read<EndDateTimeCubit>().selectDateTime(_selectedDateTime);

        // Invoke the callback with the selected date and time
        widget.onDateTimeSelected(_selectedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<EndDateTimeCubit, DateTime>(
      builder: (context, selectedDateTime) {
        final DateFormat dateFormat = DateFormat(widget.format);
        final String formattedDateTime = dateFormat.format(_selectedDateTime) +
            ' ' +
            _selectedTime.format(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 2.0, left: screenWidth * .055),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Color(0xFF525252),
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: screenWidth * .83,
              height: screenHeight * .057,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: .75, color: Colors.black),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 24),
                child: InkWell(
                  onTap: _selectDateTime,
                  child: IgnorePointer(
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center the TextFormField
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 66, 65, 65),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: widget.hint,
                              hintStyle: const TextStyle(
                                color: Color(0xFFA8A8A8),
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            controller:
                                TextEditingController(text: formattedDateTime),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S
                                    .of(context)
                                    .Please_enter_a_valid_date_and_time;
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            size: 20,
                            color: Colors.grey,
                          ),
                          onPressed: _selectDateTime,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
