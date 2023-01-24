
import 'package:flutter/material.dart';
import 'package:food_app/utils/dimensions.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({
    super.key,
    required this.text,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  double textHeight = Dimensions.screnHeight / 4.9;
  bool hiddenText = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
            )
          : Column(
              children: [
                Text(
                  hiddenText ? ('$firstHalf...') : (firstHalf + secondHalf),
                  style: TextStyle(fontSize: Dimensions.font15),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        hiddenText ? 'Show more' : 'show less',
                        style:
                            TextStyle(color: Colors.green[100], fontSize: 13),
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: Colors.green[100],
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
