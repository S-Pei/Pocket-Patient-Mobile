import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'colours.dart' as colours;
import 'fonts.dart' as fonts;
import 'pages.dart' as pages;
import 'globals.dart' as globals;

// MEDICAL INST WITH ACCESS LOGO
// At top right corner of home page
class MedInsAccLogo extends StatelessWidget {
  const MedInsAccLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 60.0,
        right: 20.0,
        child: Container(
          width: 80,
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: const Color(0xa1dade),
            color: colours.mainCyan,
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.apartment,
            size: 40.0,
            color: Colors.black,
          ),
        ));
  }
}

// HOME ICON
class HomeIcon extends StatelessWidget {
  const HomeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90.0,
      left: 40.0,
      child: IconButton(
        icon: const Icon(
          Icons.home,
          size: 40.0,
          color: Colors.black,
        ),
        onPressed: () {
          globals.overlay.hideOverlay();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const pages.HomePage()),
          );
        },
      ),
    );
  }
}

// information with (bold) title: info
class InfoFormat extends StatelessWidget {
  const InfoFormat({super.key, required this.title, required this.info});

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      softWrap: true,
      TextSpan(
          text: '$title: ',
          style: fonts.subtitle,
          children: <TextSpan>[TextSpan(text: info, style: fonts.info)]),
    );
  }
}

// Long Buttons to navigate to another page
class NavigateLongButton extends StatelessWidget {
  const NavigateLongButton({super.key, required this.word, required this.nextPage});

  final String word;
  final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return LongButton(word: word,
        onPress: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );});
  }
}

// LONG BUTTONS IN GENERAL
class LongButton extends StatelessWidget {
  const LongButton({super.key, required this.word, required this.onPress});

  final String word;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            textStyle: fonts.subtitle,
            backgroundColor: colours.buttonCyan,
            foregroundColor: Colors.white),
        onPressed: onPress,
        child: Text(word),
      ),
    );
  }
}

// PRINT BUTTON
class PrintButton extends StatelessWidget {
  const PrintButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        textStyle: fonts.subtitle,
        backgroundColor: colours.buttonPink,
        foregroundColor: Colors.white,
        elevation: 10,
        minimumSize: const Size(100, 30),
      ),
      onPressed: () {},
      icon: const Icon(Icons.print),
      label: const Text('print'),
    );
  }
}

// BOTTOM NAV BAR ELEM
class NavBarElem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final int index;

  const NavBarElem({
    super.key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // flex: 5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colours.mainCyan,
          border: Border(
            left: index == 0
                ? BorderSide.none
                : BorderSide(width: 5.0, color: colours.lightCyan),
            right: index == 2
                ? BorderSide.none
                : BorderSide(width: 5.0, color: colours.lightCyan),
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              IconButton(
                onPressed: onPressed,
                icon: Icon(icon, size: selected ? 26 : 25, color: Colors.black),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: selected ? 14 : 12,
                      height: 1,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  // softWrap: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// OVERLAY
class CustomOverlay {
  OverlayEntry? _overlayEntry;
  static late OverlayState overlayState;

  void showOverlay(BuildContext context, Widget toShow) {
    overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Center(
          child: toShow,);
      },
    );
    overlayState?.insert(_overlayEntry!);
  }

  void hideOverlay() {
    print(_overlayEntry);
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

// AUTHENTICATION OVERLAY WIDGET
class OverlayWidget extends StatefulWidget {
  const OverlayWidget({super.key});

  @override
  State<StatefulWidget> createState() => _OverlayState();
}

class _OverlayState extends State<OverlayWidget> {

  void grantAccess() {
    Map<String, dynamic> data = {};
    data['event'] = 'GRANT_PATIENT_DATA_ACCESS';
    final json = jsonEncode(data);
    print(data);
    globals.channel.sink.add(json);
  }
  final List<bool> _isCheckedList = [false, false];
  List<String> strs = ['I consent to share all medical data to this hospital for treatment '
      'purposes only for 7 days', 'I wish to share selected data only for 7 days'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: Center(
          child: Material(child:
          ColouredBox(colour: colours.bgGrey,
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            padding: 35.0,
            radius: 30.0,
            outerPadding: 25.0,
            child: SingleChildScrollView(
                child: Column(
                    children: [
                      Text('St Mary Hospital is requesting for your data.',
                        style: fonts.title,
                        softWrap: true,),
                      Column(
                          children: [
                            ListTileTheme(
                              contentPadding: EdgeInsets.all(0),
                              child: CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                title: Text(strs[0]),
                                value: _isCheckedList[0],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isCheckedList[0] = value!;
                                    _isCheckedList[1] = !value!;
                                  });
                                },
                              ),),
                            ListTileTheme(
                              contentPadding: EdgeInsets.all(0),
                              child: CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                title: Text(strs[1]),
                                value: _isCheckedList[1],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isCheckedList[1] = value!;
                                    _isCheckedList[0] = !value!;
                                  });
                                },
                              ),),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children :[
                                  ShortButton(
                                      text: 'decline',
                                      color: colours.buttonRed,
                                      onPress: () => {}),
                                  ShortButton(
                                      text: 'accept',
                                      color: colours.buttonGreen,
                                      onPress: () => {grantAccess(),
                                        globals.overlay.hideOverlay(),
                                        if (_isCheckedList[1]) {
                                          globals.overlay.showOverlay(context, const SelectMedicalHistoryOverlay())
                                        }
                                      }),
                                ]
                            )
                          ]
                      )
                    ])),
          )),
    ),
    );
  }
}

// SHORT BUTTON
class ShortButton extends StatelessWidget {
  const ShortButton({super.key, required this.text, required this.color, required this.onPress});
  final String text;
  final Color color;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress, child: Text(text),
    style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
    elevation: 10,
      minimumSize: const Size(100, 30),),
    );
  }
}

// COLOURED BOX
class ColouredBox extends StatelessWidget {
  const ColouredBox({super.key, required this.height, required this.width, required this.padding, required this.colour, required this.child, required this.radius, required this.outerPadding});
  final double height;
  final double width;
  final double padding;
  final Color colour;
  final Widget child;
  final double radius;
  final double outerPadding;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: Padding(padding: EdgeInsets.only(left: outerPadding, right: outerPadding),
            child:
            DecoratedBox(
                decoration: BoxDecoration(color: colour,
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(4, 8), // changes position of shadow
                    ),
                  ],),
                child: Padding(padding: EdgeInsets.all(padding),
                    child: child))
        )
    );
  }
}

List<Widget> showMedicalHistory(Map<String, Pair<String, String>> data, BuildContext context, bool editMode) {
  print(data);
  List<Widget> widgets = [];
  for (var entry in data.entries) {
    widgets.add(VisibilityTile(data: entry.value, editMode: editMode, uuid : entry.key));
    widgets.add(SizedBox(height: 10,));
  }
  return widgets;
}

class VisibilityTile extends StatefulWidget {
  const VisibilityTile({super.key, required this.data, required this.editMode, required this.uuid});
  final Pair<String, String> data;
  final bool editMode;
  final String uuid;

  @override
  State<StatefulWidget> createState() => _VisibilityTileState(data, editMode, uuid);
}

class _VisibilityTileState extends State<VisibilityTile> {
  Pair<String, String> _data;
  _VisibilityTileState(this._data, this.editMode, this.uuid);
  bool visible = true;
  bool editMode;
  String uuid;

  @override
  Widget build(BuildContext context) {
    Widget widget = ColouredBox(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        padding: 10.0,
        colour: editMode ? (visible ? colours.contentCyan : colours.unselectGrey) :
            colours.contentCyan,
        child: Row(children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                  width: 50,
                  child: DefaultTextStyle(child: Text(_data.first), style: fonts.content, softWrap: true,))),
          Flexible(
              fit: FlexFit.tight,
              flex: 7,
              child: Container(
                  width: 250,
                  child: DefaultTextStyle(child: Text(_data.second), style: fonts.content, softWrap: true,)
              ))]),
        radius: 0,
        outerPadding: 0);
    Widget visIcon = IconButton(onPressed: () {
      setState(() {
        visible = false;
        globals.toHide.add(uuid);
      });
    }, icon: Icon(Icons.visibility));
    Widget nonVisIcon = IconButton(onPressed: () {
      setState(() {
        visible = true;
        globals.toHide.remove(uuid);
      });
    }, icon: Icon(Icons.visibility_off));
    if (editMode) {
      return Row(
          children: [Flexible(flex:2, child: visible ? visIcon : nonVisIcon),
            SizedBox(width: 10,),
            Flexible(flex: 20, child: widget),]
      );
    }
    return widget;
  }
}

class MedicalHistoryTitle extends StatelessWidget {
  const MedicalHistoryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ColouredBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        padding: 10.0,
        colour: colours.superLightCyan,
        radius: 10.0,
        outerPadding: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          DefaultTextStyle(style: fonts.smallTitle, child: Text('My Medical History')),
          DefaultTextStyle(style: fonts.smallInfo, child: Text('Last Updated: 25/4/2023')),
          ],
        ));
  }

}

// SELECT MEDICAL HISTORY PAGE
  class SelectMedicalHistoryOverlay extends StatefulWidget {
    const SelectMedicalHistoryOverlay({super.key});

    @override
    State<StatefulWidget> createState() => _SelectMedicalHistoryOverlayState();

  }

  class _SelectMedicalHistoryOverlayState extends State<SelectMedicalHistoryOverlay> {
  
    void sendToHideMh(List<String> ids) {
      Map<String, dynamic> data = {};
      data['event'] = 'PATIENT_HIDE_RECORDS';
      data['ids'] = ids;
      final json = jsonEncode(data);
      print(data);
      globals.channel.sink.add(json);
    }

    List<String> toHide = [];
    @override
    Widget build(BuildContext context) {
      List<Widget> entriesWidgets = showMedicalHistory(globals.patientData!.getMedHisSummary(), context, true);
      return Container(
      color: Colors.white.withOpacity(0.5),
      child: Center(
        child:
          Stack(
          children: [Column(
              children: [Flexible(
                  child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        globals.medicalHistoryTitle,
                        SizedBox(height: 30,),
                      ] + entriesWidgets +
                      [
                        SizedBox(height: 30,),
                        LongButton(word: 'Confirm Data Selection', onPress: () {
                          sendToHideMh(globals.toHide);
                          globals.overlay.hideOverlay();})
                      ]))),
                  Container(height: 100, color: Colors.transparent,),
              ],),
            globals.homeIcon,
          ]),
        )
      );
    }

  }