import 'package:flutter/material.dart';

/// A widget that allows the user to select a date.
class DateSelectorWidget extends StatefulWidget {
  /// A callback function that gets called when a date is selected.
  final void Function(DateTime) onDateSelected;

  /// Constructs a `DateSelectorWidget`.
  ///
  /// The `onDateSelected` parameter must not be null.
  const DateSelectorWidget({super.key, required this.onDateSelected});

  @override
  DateSelectorWidgetState createState() => DateSelectorWidgetState();
}

/// The state for the `DateSelectorWidget`.
class DateSelectorWidgetState extends State<DateSelectorWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  /// Opens a date picker dialog for selecting a date.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)), // 2 years from now
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateSelected(_selectedDate); // Notifies the new selected date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${_selectedDate.toLocal()}'.split(' ')[0],
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const Icon(Icons.calendar_today, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
