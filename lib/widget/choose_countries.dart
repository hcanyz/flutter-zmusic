import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netease_music_api/netease_music_api.dart';
import 'package:zmusic/common/res.dart';
import 'package:zmusic/common/toast_ext.dart';

class ChooseCountriesData {
  String zh;
  String en;
  String locale;
  String code;
  String showLine;

  ChooseCountriesData(
      {this.zh, this.en, this.locale, this.code, this.showLine});
}

void showChooseCountriesDialog(
    BuildContext context, ValueChanged<String> callback) async {
  SystemChannels.textInput.invokeMethod("TextInput.hide");
  var result = await NeteaseMusicApi().countriesCodeList();
  if (result.codeEnum != RetCode.Ok) {
    BotToastExt.showText(text: result.realMsg);
    callback.call("");
    return;
  }
  List<ChooseCountriesData> data = List();
  List<String> navigation = List();
  result.data.forEach((element) {
    navigation.add(element.label[0]);
    data.add(ChooseCountriesData(
        zh: element.label, en: "", locale: "", code: "", showLine: "0"));
    element.countryList.forEach((countryItem) {
      data.add(ChooseCountriesData(
          zh: countryItem.zh,
          en: countryItem.en,
          locale: countryItem.locale,
          code: countryItem.code,
          showLine: "1"));
    });
  });
  showDialog(
      context: context,
      builder: (_) => ChooseCountriesDialog(
            data: data,
            navigation: navigation,
            callback: (value) {
              if (value != null) {
                print(value.zh);
                callback.call(value.code);
              } else {
                callback.call("");
              }
            },
          ));
}

class ChooseCountriesDialog extends Dialog {
  final List<ChooseCountriesData> data;
  final List<String> navigation;
  final ValueChanged<ChooseCountriesData> callback;

  ChooseCountriesDialog(
      {Key key,
      @required this.data,
      @required this.navigation,
      @required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChooseCountriesWidget(
        data: data, navigation: navigation, callback: callback);
  }
}

class ChooseCountriesWidget extends StatefulWidget {
  final List<ChooseCountriesData> data;
  final List<String> navigation;
  final ValueChanged<ChooseCountriesData> callback;

  ChooseCountriesWidget(
      {Key key,
      @required this.data,
      @required this.navigation,
      @required this.callback});

  @override
  _ChooseCountriesWidgetState createState() {
    return _ChooseCountriesWidgetState(
        data: data, navigation: navigation, callback: callback);
  }
}

class _ChooseCountriesWidgetState extends State<ChooseCountriesWidget> {
  final List<ChooseCountriesData> data;
  final List<String> navigation;
  final ValueChanged<ChooseCountriesData> callback;
  String letter = "A";
  bool showLetter = false;
  var diff = 0.0;
  double _offsetContainer = 0.0;
  var _heightScroller;
  var posSelected = 0;
  var _sizeHeightContainer;
  ScrollController _controllerScroll;

  @override
  void initState() {
    _controllerScroll = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerScroll.dispose();
    super.dispose();
  }

  _ChooseCountriesWidgetState(
      {Key key,
      @required this.data,
      @required this.navigation,
      @required this.callback});

  Widget getListItem(BuildContext context, ChooseCountriesData data) {
    return data.showLine == "1"
        ? Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 40.0),
                height: 50,
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(left: 20.0),
                  title: Text(
                    data.zh,
                    style: TextStyle(fontSize: 14, color: color_text_primary),
                  ),
                  trailing: Text(
                    "+${data.code}",
                    style: TextStyle(fontSize: 14, color: color_text_secondary),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    callback.call(data);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 40.0),
                child: Divider(
                  height: 1.0,
                ),
              ),
            ],
          )
        : Container(
            height: 50,
            color: Colors.white,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 20.0, right: 40.0),
              title: Text(
                data.zh,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color_text_primary),
              ),
            ),
          );
  }

  _getAlphabetItem(int index) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 40,
          height: 20,
          alignment: Alignment.center,
          child: Text(
            navigation[index],
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if ((_offsetContainer + details.delta.dy) >= 0 &&
        (_offsetContainer + details.delta.dy) <=
            (_sizeHeightContainer - _heightScroller)) {
      _offsetContainer += details.delta.dy;
      posSelected =
          ((_offsetContainer / _heightScroller) % navigation.length).round();
      var _text = navigation[posSelected];
      setState(() {
        letter = _text;
        for (int i = 0; i < data.length; i++) {
          if (_text
                  .toString()
                  .compareTo(data[i].zh.toString().toUpperCase()[0]) ==
              0) {
            _controllerScroll.jumpTo(50.0 * i);
          }
        }
      });
    }
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _offsetContainer = details.globalPosition.dy - diff;
    setState(() {
      showLetter = true;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      showLetter = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: EdgeInsets.only(top: 50.0),
        decoration: ShapeDecoration(
          color: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      callback.call(null);
                      Navigator.of(context).pop();
                    },
                  ),
                  Text("选择国家和地区",
                      style: TextStyle(
                          fontSize: 18,
                          color: color_text_primary,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: LayoutBuilder(
                  builder: (context, box) {
                    diff =
                        MediaQuery.of(context).size.height - box.biggest.height;
                    _heightScroller = (box.biggest.height) / navigation.length;
                    _sizeHeightContainer = (box.biggest.height);
                    return Stack(
                      children: [
                        ListView(
                          controller: _controllerScroll,
                          children: []
                            ..addAll(data.map((e) => getListItem(context, e))),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalDragUpdate,
                            onVerticalDragStart: _onVerticalDragStart,
                            onVerticalDragEnd: _onVerticalDragEnd,
                            child: Container(
                              margin: EdgeInsets.only(right: 10.0),
                              width: 25,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Color(0xffa3a3a3)),
                              height: 28.0 * navigation.length,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: []..addAll(
                                    List.generate(navigation.length,
                                        (index) => _getAlphabetItem(index)),
                                  ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Visibility(
                            visible: showLetter,
                            child: Container(
                              height: 85.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                color: Color(0xff444444),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff444444),
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 5.0),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                letter,
                                style: TextStyle(
                                    fontSize: 36,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
