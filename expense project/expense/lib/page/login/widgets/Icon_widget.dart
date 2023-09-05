import 'dart:async';

import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  Icon? icon;
  IconWidget({this.icon});

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  Timer? _time;
  bool checkDuration = false;
  @override
  void initState() {
    super.initState();
    _time = Timer.periodic(Duration(seconds: 3), (t) {
      if (mounted) {
        setState(() {
          checkDuration = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _time?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: checkDuration ? 0 : 1,
      duration: Duration(milliseconds: 300),
      child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.black54, borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.center,
          child: widget.icon),
    );
  }
}
