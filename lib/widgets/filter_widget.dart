import 'package:flutter/material.dart';

class SearchFilterBody extends StatefulWidget {
  RangeValues currentRangeValues;
  void Function(RangeValues values) filterSubmit;
  SearchFilterBody(
      {super.key,
      required this.currentRangeValues,
      required this.filterSubmit});

  @override
  State<SearchFilterBody> createState() => _SearchFilterBodyState();
}

class _SearchFilterBodyState extends State<SearchFilterBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Filter",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
        const Padding(
          padding: const EdgeInsets.only(left: 20),
          child:
              const Text(textAlign: TextAlign.start, "Price range 0 - 2000 \$"),
        ),
        RangeSlider(
          activeColor: Colors.pink,
          values: widget.currentRangeValues,
          max: 2000,
          divisions: 5,
          labels: RangeLabels(
            widget.currentRangeValues.start.round().toString(),
            widget.currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              widget.currentRangeValues = values;
            });
          },
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              widget.filterSubmit(widget.currentRangeValues);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.pink,
              // Background color
            ),
            child: const Text(
              "Submit",
            ),
          ),
        )
      ]),
    );
  }
}
