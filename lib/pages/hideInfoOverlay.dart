import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import '../resources/components.dart';

// SELECT MEDICAL HISTORY PAGE
class SelectMedicalHistoryOverlay extends StatefulWidget {
  const SelectMedicalHistoryOverlay({super.key});

  @override
  State<StatefulWidget> createState() => _SelectMedicalHistoryOverlayState();

}

class _SelectMedicalHistoryOverlayState extends State<SelectMedicalHistoryOverlay> {

  void sendToHideMh(Set<String> ids) {
    Map<String, dynamic> data = {};
    data['event'] = 'GRANT_PATIENT_DATA_ACCESS';
    data['ids'] = ids.toList();
    final json = jsonEncode(data);
    print(data);
    channel.sink.add(json);
    toHide.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> entriesWidgets = showMedicalHistory(patientData!.getMedHisSummary(), context, true);
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
                              medicalHistoryTitle,
                              SizedBox(height: 30,),
                            ] + entriesWidgets +
                                [
                                  SizedBox(height: 30,),
                                  LongButton(word: 'Confirm Data Selection', onPress: () {
                                    sendToHideMh(toHide);
                                    overlay.hideOverlay();})
                                ]))),
                  Container(height: 100, color: Colors.transparent,),
                ],),
                homeIcon,
              ]),
        )
    );
  }
}

// EACH ROW TO HIDE MEDICAL INFORMATION
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
        colour: editMode ? (visible ? contentCyan : unselectGrey) :
        contentCyan,
        child: Row(children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                  width: 50,
                  child: DefaultTextStyle(child: Text(_data.first), style: content, softWrap: true,))),
          Flexible(
              fit: FlexFit.tight,
              flex: 7,
              child: Container(
                  width: 250,
                  child: DefaultTextStyle(child: Text(_data.second), style: content, softWrap: true,)
              ))]),
        radius: 0,
        outerPadding: 0);
    Widget visIcon = IconButton(onPressed: () {
      setState(() {
        visible = false;
        toHide.add(uuid);
      });
    }, icon: Icon(Icons.visibility));
    Widget nonVisIcon = IconButton(onPressed: () {
      setState(() {
        visible = true;
        toHide.remove(uuid);
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