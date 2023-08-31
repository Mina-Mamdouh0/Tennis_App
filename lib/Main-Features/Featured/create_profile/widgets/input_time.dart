import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../cubits/time_cubit.dart';

class InputTimeField extends StatefulWidget {
  final String text;
  final String hint;
  final ValueChanged<TimeOfDay?> onTimeSelected;
  final IconData? suffix;

  const InputTimeField({
    Key? key,
    required this.text,
    required this.hint,
    required this.onTimeSelected,
    this.suffix,
  }) : super(key: key);

  @override
  _InputTimeFieldState createState() => _InputTimeFieldState();
}

class _InputTimeFieldState extends State<InputTimeField> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<TimeCubit>().state?.format(context) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<TimeCubit, TimeOfDay?>(
      builder: (context, selectedTime) {
        return SizedBox(
          width: screenWidth * .83,
          child: Column(
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
              InkWell(
                onTap: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                  );

                  if (pickedTime != null) {
                    widget.onTimeSelected(pickedTime);
                    setState(() {
                      _controller.text = pickedTime.format(context);
                    });
                  }
                },
                child: IgnorePointer(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon:
                          widget.suffix != null ? Icon(widget.suffix) : null,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: widget.hint,
                      hintStyle: const TextStyle(
                        color: Color(0xFFA8A8A8),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15), // Remove the padding

                      filled: true, // Enable background fill
                      fillColor: Colors.white, // Set the background color
                    ),
                    controller: _controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).Please_enter_a_valid_time;
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
