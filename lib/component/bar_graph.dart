import 'dart:math';

import 'package:flutter/material.dart';

class BarGraph extends StatefulWidget {
  const BarGraph({
    super.key,
    required this.totalBudget,
    required this.expenses,
    required this.totalWidth,
  });

  final double totalBudget;
  final double totalWidth;
  final List<double> expenses;

  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  late double _budgetLeft;

  final List<Widget> _bars = [];

  _getBars() {
    for (var i = 0; i < widget.expenses.length; i++) {
      final bool isFinalBar = i == widget.expenses.length - 1; //bool to round topRight & bottomRight of bar radius if it's the last in the sequence
      double barWidth;

      final double expense = widget.expenses[i];

      if (expense < _budgetLeft) {
        barWidth =
            (expense / widget.totalBudget) * widget.totalWidth;
        _bars.add(
          _Bars(
            width: barWidth,
            isFinalBar: isFinalBar,
          ),
        );
      } else {
        barWidth = (_budgetLeft / widget.totalBudget) * widget.totalWidth;
        _bars.add(
          _Bars(
            width: barWidth,
            isFinalBar: isFinalBar,
          ),
        );
        break;
      }
      _budgetLeft -= expense;
    }
    return _bars;
  }

  @override
  void initState() {
    super.initState();
    _budgetLeft = widget.totalBudget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color(0xFFDFDFDF),
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Row(
        children: _getBars(),
      ),
    );
  }
}

class _Bars extends StatelessWidget {
  const _Bars({
    required this.width,
    this.isFinalBar = false,
  });

  final double width;
  final bool isFinalBar;

  Color _getRandomColor() {
    Random random = Random();

    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      width: width,
      decoration: BoxDecoration(
        color: _getRandomColor(),
        borderRadius: isFinalBar
            ? const BorderRadius.only(
                bottomRight: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              )
            : null,
      ),
    );
  }
}
