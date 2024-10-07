import 'package:flutter/material.dart';
import '../l10n/strings.dart';

class FlutterCustomCalendar extends StatefulWidget {
  DateTime selectedDate;
  final Color calenderBackgroundColor;
  final Color selectedDayColor;
  final Color unselectedDayColor;
  final Color selectedDayTextColor;
  final Color unselectedDayTextColor;
  final String dayTextStyle;
  final double dayTextFontSize;
  final FontWeight dayTextFontWeight;
  final double dayOfWeekTextFontSize;
  final FontWeight dayOfWeekTextFontWeight;
  final Color dayOfWeekTextColor;
  final double cornerRadius;
  final Color shadowColor;
  final double shadowSpreadRadius;
  final double shadowBlurRadius;
  final Color borderColor;
  final Function(DateTime)? onDateSelected;
  final List<String> daysOfWeek;
  final IconData previousMonthIcon;
  final IconData nextMonthIcon;
  final Color iconColor;

  FlutterCustomCalendar({
    Key? key,
    required this.selectedDate,
    this.calenderBackgroundColor = Colors.white,
    this.selectedDayColor = Colors.orange,
    this.unselectedDayColor = Colors.transparent,
    this.selectedDayTextColor = Colors.white,
    this.unselectedDayTextColor = Colors.black,
    this.dayTextFontSize = 16,
    this.dayTextFontWeight = FontWeight.bold,
    this.dayTextStyle = 'Jose',
    this.dayOfWeekTextFontSize = 14,
    this.dayOfWeekTextFontWeight = FontWeight.bold,
    this.dayOfWeekTextColor = Colors.black,
    this.cornerRadius = 12.0,
    this.shadowColor = Colors.grey,
    this.shadowSpreadRadius = 2.0,
    this.shadowBlurRadius = 5.0,
    this.borderColor = Colors.transparent,
    this.onDateSelected,
    this.daysOfWeek = const ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'],
    this.previousMonthIcon = Icons.arrow_back_ios,
    this.nextMonthIcon = Icons.arrow_forward_ios,
    this.iconColor = Colors.grey,

  }) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<FlutterCustomCalendar> {
  late DateTime _firstDayOfMonth;
  late DateTime _lastDayOfMonth;

  @override
  void initState() {
    super.initState();
    _firstDayOfMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month, 1);
    _lastDayOfMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Container(
        decoration: BoxDecoration(
          color: widget.calenderBackgroundColor,
          borderRadius: BorderRadius.circular(widget.cornerRadius),
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor.withOpacity(0.5),
              spreadRadius: widget.shadowSpreadRadius,
              blurRadius: widget.shadowBlurRadius,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Theme.of(context).scaffoldBackgroundColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(locale),
            _buildDaysOfWeek(locale),
            _buildCalendarDays(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String locale) {
    List<String> months = AppLocalizations.getMonths(locale);
    String monthName = months[widget.selectedDate.month - 1];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(widget.previousMonthIcon, color: widget.iconColor),
            onPressed: _previousMonth,
          ),
          Text(
            '$monthName ${widget.selectedDate.year}', // Ay adı ve yılı göster
            style: TextStyle(
              fontSize: widget.dayTextFontSize,
              fontWeight: widget.dayTextFontWeight,
              fontFamily: widget.dayTextStyle,
            ),
          ),
          IconButton(
            icon: Icon(widget.nextMonthIcon, color: widget.iconColor),
            onPressed: _nextMonth,
          ),
        ],
      ),
    );
  }


  Widget _buildDaysOfWeek(String locale) {
    List<String>? days = AppLocalizations.getDays(locale);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days.map((day) {
        return Text(
          day,
          style:TextStyle(
            fontSize: widget.dayOfWeekTextFontSize,
            fontWeight: widget.dayOfWeekTextFontWeight,
            color: widget.dayOfWeekTextColor,
            fontFamily: widget.dayTextStyle,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarDays() {
    int daysInMonth = _lastDayOfMonth.day;
    int firstDayOfWeek = _firstDayOfMonth.weekday;

    List<Widget> days = [];
    for (int i = 1; i < firstDayOfWeek; i++) {
      days.add(const SizedBox(width: 32));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      days.add(
        GestureDetector(
          onTap: () {
            setState(() {
              widget.selectedDate = DateTime(widget.selectedDate.year, widget.selectedDate.month, day);
            });
            if (widget.onDateSelected != null) {
              widget.onDateSelected!(widget.selectedDate);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: widget.selectedDate.day == day ? widget.selectedDayColor : widget.unselectedDayColor,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              day.toString(),
              style: TextStyle(
                color: widget.selectedDate.day == day ? widget.selectedDayTextColor : widget.unselectedDayTextColor,
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      children: days,
    );
  }

  void _previousMonth() {
    setState(() {
      widget.selectedDate = DateTime(widget.selectedDate.year, widget.selectedDate.month - 1, widget.selectedDate.day);
      _firstDayOfMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month, 1);
      _lastDayOfMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month + 1, 0);
    });
  }

  void _nextMonth() {
    setState(() {
      widget.selectedDate = DateTime(widget.selectedDate.year, widget.selectedDate.month + 1, widget.selectedDate.day);
      _firstDayOfMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month, 1);
      _lastDayOfMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month + 1, 0);
    });
  }
}
