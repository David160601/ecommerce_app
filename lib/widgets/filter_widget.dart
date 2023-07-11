import 'package:ecommerce_app/models/category_model.dart';
import 'package:flutter/material.dart';

class SearchFilterBody extends StatefulWidget {
  RangeValues currentRangeValues;
  List<Category> categories;
  Category? selectedCategory;
  void Function(RangeValues values, Category? selectedCategory) filterSubmit;
  SearchFilterBody(
      {super.key,
      required this.currentRangeValues,
      required this.filterSubmit,
      required this.categories,
      required this.selectedCategory});

  @override
  State<SearchFilterBody> createState() => _SearchFilterBodyState();
}

class _SearchFilterBodyState extends State<SearchFilterBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230,
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
          padding: EdgeInsets.only(left: 20),
          child: Text(textAlign: TextAlign.start, "Price range 0 - 2000 \$"),
        ),
        RangeSlider(
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton<Category>(
            value: widget.selectedCategory,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            isExpanded: true,
            onChanged: (Category? value) {
              // This is called when the user selects an item.
              setState(() {
                widget.selectedCategory = value;
              });
            },
            items: [
              const DropdownMenuItem<Category>(
                value: null, // Assign null as the value
                child: Text(
                    "Select Category"), // Customize the displayed text for the null option
              ),
              ...widget.categories.map((Category value) {
                return DropdownMenuItem<Category>(
                  value: value,
                  child: Text(value.name ?? ""),
                );
              }).toList()
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              widget.filterSubmit(
                  widget.currentRangeValues, widget.selectedCategory);
            },
            child: const Text(
              "Submit",
            ),
          ),
        )
      ]),
    );
  }
}
