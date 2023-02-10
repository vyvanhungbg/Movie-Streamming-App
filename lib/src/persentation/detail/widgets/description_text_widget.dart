import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;
  final int limit;
  final TextStyle? textStyle;

  DescriptionTextWidget(
      {required this.text, required this.limit, this.textStyle});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > widget.limit) {
      firstHalf = widget.text.substring(0, widget.limit);
      secondHalf = widget.text.substring(widget.limit, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : InkWell(
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
            child: RichText(
              text: TextSpan(
                  text:
                      flag ? ("$firstHalf...") : (firstHalf + secondHalf),
                  style: widget.textStyle,
                  children: [
                    TextSpan(
                      text: flag ? "show more" : "show less",
                      style: const TextStyle(color: Colors.blue),
                    )
                  ]),
            ),
          ),
    );
  }
}
