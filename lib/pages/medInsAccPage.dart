import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/revokeAccessOverlay.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import '../resources/components.dart';

class MedInsAccNotifier extends ValueNotifier<int> {
  MedInsAccNotifier(int medication) : super(changeNum);

  void updateHospsChanges(int changeNum) {
    print("print hospital of update: ");
    print(changeNum);
    value = changeNum;
  }
}

// MEDICAL INSTITUTIONS WITH ACCESS TO MY DATA PAGE
class MedAccInsPage extends StatefulWidget {
  MedAccInsPage({super.key});

  @override
  State<StatefulWidget> createState() => _MedAccInsPageState();
}

class _MedAccInsPageState extends State<MedAccInsPage> {

  Widget title = TitleColouredBox(
      widgets: [Text('Medical Institutions with Access to My Data', style: subtitle, softWrap: true,)], height: 90);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: medInsAccNotifier,
        builder: (context, value, child)
    {
      return Scaffold(
        body: Stack(
          children: [
            Container(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 120,
                          ),
                          title,
                          SizedBox(height: 30,),
                        ] + showMedIns(hosps, context)))),
            homeIcon,
          ],
        ),
      );
    });
  }
}

// EACH ROW TO HIDE MEDICAL INFORMATION
class MedInsAccTile extends StatefulWidget {
  const MedInsAccTile({super.key, required this.data, required this.id, required this.visible});
  final Pair<String, String> data;
  final String id;
  final bool visible;

  @override
  State<StatefulWidget> createState() => _MedInsAccTileState(data, id, visible);
}

class _MedInsAccTileState extends State<MedInsAccTile> {
  Pair<String, String> _data;
  _MedInsAccTileState(this._data, this.id, this.visible);
  bool visible;
  String id;

  @override
  Widget build(BuildContext context) {
    Widget visibilitySwitch = Switch(value: visible,
        onChanged: (bool value) {setState(() {
          visible = value;
          if (!value) {
            overlay.showOverlay(context, RevokeAccessOverlay(toRevokeId: id));
          }
        });});
    return ColouredBox(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        padding: 10.0,
        colour: visible ? contentCyan : unselectGrey,
        child: Row(children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 13,
              child: Container(
                  width: 250,
                  child: DefaultTextStyle(child: Text(_data.first), style: content, softWrap: true,))),
          Flexible(
              fit: FlexFit.tight,
              flex: 7,
              child: Container(
                  width: 50,
                  child: DefaultTextStyle(child: Text(_data.second), style: content, softWrap: true,)
              )),
          Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: visibilitySwitch)]),
        radius: 10,
        outerPadding: 0);
  }

  void cancelRevokeAccess() {
    setState(() {
      visible = true;
    });
  }
}

class TitleRow extends StatelessWidget {
  const TitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: SizedBox(width: 5,)),
      Flexible(
          fit: FlexFit.tight,
          flex: 33,
          child: Container(
              width: 50,
              child: DefaultTextStyle(child: Text('Medical Institution'), style: boldContent, softWrap: true,))),
      Flexible(
          fit: FlexFit.tight,
          flex: 30,
          child: Container(
              width: 250,
              child: DefaultTextStyle(child: Text('Date of expiry'), style: boldContent, softWrap: true,)
          )),
    ]);
  }

}

List<Widget> showMedIns(Map<String, Pair<String, String>> data, BuildContext context) {
  List<Widget> widgets = [];
  print('hosp: $data');
  widgets.add(TitleRow());
  widgets.add(SizedBox(height: 10,));
  for (var entry in data.entries) {
    bool? visible = medAccIncVisibility[entry.key];
    print('visibl: $medAccIncVisibility');
    if (visible != null) {
      print('print entry');
      Widget widget = MedInsAccTile(
        data: entry.value, id: entry.key, visible: visible,);
      widgets.add(widget);
      widgets.add(SizedBox(height: 10,));
      medAccIncEntries[entry.key] = widget;
    }
  }
  return widgets;
}

