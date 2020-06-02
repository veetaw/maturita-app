import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizza/common/widget/custom_input_text.dart';
import 'package:pizza/style/app_styles.dart';

class TimeDeltaSelector extends StatelessWidget {
  final BoxConstraints constraints;

  const TimeDeltaSelector({
    Key key,
    @required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double containerHeight = 50;
    final double padding = containerHeight / 2;

    bool isPortrait = constraints.maxHeight > constraints.maxWidth;

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: padding),
            child: Container(
              height: padding * 3,
              width: 1,
              color: AppStyles.kPrimaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: padding),
            child: Container(
              height: padding * 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 1,
                    width: padding + 10,
                    color: AppStyles.kPrimaryColor,
                  ),
                  Container(
                    height: 1,
                    width: padding + 10,
                    color: AppStyles.kPrimaryColor,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              TimePicker(
                isPortrait: isPortrait,
                containerHeight: containerHeight,
                defaultText: "Apertura",
              ),
              Padding(
                padding: EdgeInsets.only(top: padding),
              ),
              TimePicker(
                isPortrait: isPortrait,
                containerHeight: containerHeight,
                defaultText: "Chiusura",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  const TimePicker({
    Key key,
    @required this.isPortrait,
    @required this.containerHeight,
    @required this.defaultText,
    this.onTap,
  }) : super(key: key);

  final bool isPortrait;
  final double containerHeight;
  final String defaultText;
  final Function(TimeOfDay) onTap;

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  String timePicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / (widget.isPortrait ? 3 : 6),
      height: widget.containerHeight,
      child: InkWell(
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then(
            (value) => setState(() {
              if (widget.onTap != null) widget.onTap(value);
              timePicked = value.format(context);
            }),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppStyles.kCardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.watch_later,
                  color: AppStyles.kPrimaryColor,
                ),
              ),
              Text(
                timePicked ?? widget.defaultText,
                style: TextStyle(
                  fontSize: timePicked != null ? 20 : 16,
                  color: AppStyles.kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}