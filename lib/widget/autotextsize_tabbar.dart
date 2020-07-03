import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AutoTextSizeTabBar extends StatefulWidget {
  AutoTextSizeTabBar(
      {this.tabBarTexts,
      this.controller,
      this.defaultTextStyle,
      this.selectTextStyle});

  final List<String> tabBarTexts;
  final TabController controller;

  final TextStyle defaultTextStyle;
  final TextStyle selectTextStyle;

  @override
  _AutoTextSizeTabBarState createState() => _AutoTextSizeTabBarState();
}

class _AutoTextSizeTabBarState extends State<AutoTextSizeTabBar> {
  int _curIndex;
  int _nextIndex = -1;
  double _t;
  TextStyle _textStyleCur;
  TextStyle _textStyleNext;

  @override
  void initState() {
    super.initState();
    _textStyleNext = widget.defaultTextStyle;
    _textStyleCur = widget.selectTextStyle;
    _curIndex = widget.controller.index;

    widget.controller.animation.addListener(() {
      _curIndex = widget.controller.animation.value.floor();
      _nextIndex = widget.controller.animation.value.round();
      var value = (widget.controller.animation.value * 10).floor() / 10;
      value = double.parse((value - value.floor()).toStringAsFixed(1));
      if (_t != value) {
        setState(() {
          _textStyleCur = TextStyle.lerp(
              widget.defaultTextStyle, widget.selectTextStyle, 1 - value);
          _textStyleNext = TextStyle.lerp(
              widget.defaultTextStyle, widget.selectTextStyle, value);
        });
        _t = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: widget.tabBarTexts.asMap().entries.map((e) {
        return Container(
            width: 51,
            height: 48,
            alignment: Alignment.center,
            child: Text(e.value,
                textAlign: TextAlign.center,
                style: e.key == _curIndex
                    ? _textStyleCur
                    : (e.key == _nextIndex
                        ? _textStyleNext
                        : widget.defaultTextStyle)));
      }).toList(),
      labelPadding: EdgeInsets.only(),
      indicator: BoxDecoration(),
      controller: widget.controller,
      isScrollable: true,
    );
  }
}
