import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DateCubit extends Cubit<DateTime> {
  DateCubit() : super(DateTime.now());

  void selectDateTime(DateTime dateTime) {
    emit(dateTime);
  }
}

class InputDate extends StatefulWidget {
  final String text;
  final String hint;
  final String format;
  final Null Function(DateTime dateTime) onDateTimeSelected;

  const InputDate({
    Key? key,
    required this.text,
    required this.hint,
    this.format = 'MMM d, yyyy',
    required this.onDateTimeSelected,
  }) : super(key: key);

  @override
  _InputDateState createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = context.read<DateCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<DateCubit, DateTime>(
      builder: (context, selectedDateTime) {
        final DateFormat dateFormat = DateFormat(widget.format);

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
              height: screenHeight * .055,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: .75, color: Colors.black),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * .007, left: 24),
                child: InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDateTime,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );

                    if (picked != null) {
                      setState(() {
                        _selectedDateTime = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                        );
                      });

                      // Use the cubit to update the selected date
                      context
                          .read<DateCubit>()
                          .selectDateTime(_selectedDateTime);

                      // Invoke the callback with the selected date
                      widget.onDateTimeSelected(_selectedDateTime);
                    }
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      readOnly: true,
                      style: const TextStyle(
                        color: Color(0xFF6E6E6E),
                        fontSize: 14,
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
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_month_outlined,
                              size: 20),
                          onPressed: () {},
                        ),
                      ),
                      controller: TextEditingController(
                        text: dateFormat.format(_selectedDateTime),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid date';
                        }
                        return null;
                      },
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
