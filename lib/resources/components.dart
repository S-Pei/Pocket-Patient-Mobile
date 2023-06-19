import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:patient_mobile_app/pages/hospitalVisitDetails.dart';
import 'package:patient_mobile_app/pages/profilePage.dart';
import 'package:patient_mobile_app/resources/objects.dart';
import 'colours.dart';
import 'fonts.dart';
import '../pages/homePage.dart';
import 'globals.dart';

// PROFILE PAGE LOGO
// At top right corner of home page
class ProfileLogo extends StatelessWidget {
  const ProfileLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50.0,
        right: 28.0,
        // child: Container(
        // width: 80,
        // height: 80,
        // alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   color: mainCyan,
        //   borderRadius: BorderRadius.circular(50),
        // ),
        child: IconButton(
          icon: const Icon(
            Icons.account_circle,
            size: 40.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
          color: Colors.black,
          // ),
        ));
  }
}

// HOME ICON
class HomeIcon extends StatelessWidget {
  const HomeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50.0,
      left: 28.0,
      child: IconButton(
        icon: const Icon(
          Icons.home,
          size: 40.0,
          color: Colors.black,
        ),
        onPressed: () {
          overlay.hideOverlay();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
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
      TextSpan(text: '$title: ', style: subtitle, children: <TextSpan>[
        TextSpan(
          text: info,
          style: infoFont,
        )
      ]),
    );
  }
}

// Long Buttons to navigate to another page
class NavigateLongButton extends StatelessWidget {
  const NavigateLongButton(
      {super.key, required this.word, required this.nextPage});

  final String word;
  final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return LongButton(
        word: word,
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        });
  }
}

// Long Buttons to navigate to another page
class NavigateShortButton extends StatelessWidget {
  const NavigateShortButton(
      {super.key, required this.word, required this.nextPage});

  final String word;
  final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return ShortButton(
      word: word,
      onPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
    );
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
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: GeneralButton(
          word: word,
          onPress: onPress,
          length: 350,
          style: subtitle,
        ));
  }
}

// Short BUTTONS IN GENERAL
class ShortButton extends StatelessWidget {
  const ShortButton({super.key, required this.word, required this.onPress});

  final String word;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        width: 170,
        child: GeneralButton(
          word: word,
          onPress: onPress,
          length: 150,
          style: boldContent,
        ));
  }
}

// GENERAL BUTTON
class GeneralButton extends StatelessWidget {
  const GeneralButton(
      {super.key,
      required this.word,
      required this.onPress,
      required this.length,
      required this.style});

  final String word;
  final void Function() onPress;
  final double length;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: length,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            textStyle: style,
            backgroundColor: buttonCyan,
            foregroundColor: Colors.white),
        onPressed: onPress,
        child: Text(
          word,
          softWrap: true,
          textAlign: TextAlign.center,
        ),
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
        textStyle: subtitle,
        backgroundColor: buttonPink,
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

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.word, required this.onPress});

  final String word;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: SizedBox(
          height: 60,
          width: 350,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                textStyle: boldContent,
                backgroundColor: buttonRed,
                foregroundColor: Colors.white),
            onPressed: onPress,
            child: Text(
              word,
              softWrap: true,
              textAlign: TextAlign.center,
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
  OverlayEntry? _prevOverlayEntry;

  void showOverlay(BuildContext context, Widget toShow) {
    overlayState = Overlay.of(context);
    if (_overlayEntry != null) {
      _prevOverlayEntry = _overlayEntry;
    }
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Center(
          child: toShow,
        );
      },
    );
    overlayState.insert(_overlayEntry!);
  }

  void hideOverlay() {
    print('overlay: ${_overlayEntry}');
    _overlayEntry?.remove();
    if (_prevOverlayEntry != null) {
      _overlayEntry = _prevOverlayEntry;
      _prevOverlayEntry = null;
    } else {
      _overlayEntry = null;
    }
  }
}

// SHORT BUTTON
class SmallButton extends StatelessWidget {
  const SmallButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onPress});
  final String text;
  final Color color;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        elevation: 10,
        minimumSize: const Size(100, 30),
      ),
    );
  }
}

// BACK BUTTON
class BackButtonBlue extends StatelessWidget {
  const BackButtonBlue({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        textStyle: subtitle,
        backgroundColor: mainCyan,
        foregroundColor: Colors.white,
        elevation: 10,
        minimumSize: const Size(100, 30),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.keyboard_double_arrow_left),
      label: const Text('back'),
    );
  }
}

// COLOURED BOX
class ColouredBox extends StatelessWidget {
  const ColouredBox(
      {super.key,
      required this.height,
      required this.width,
      required this.padding,
      required this.colour,
      required this.child,
      required this.radius,
      required this.outerPadding});
  final double height;
  final double width;
  final double padding;
  final Color colour;
  final Widget child;
  final double radius;
  final double outerPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(children: [
          SizedBox(
              // height: height,
              width: width,
              child: Padding(
                  padding:
                      EdgeInsets.only(left: outerPadding, right: outerPadding),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: colour,
                        borderRadius: BorderRadius.all(Radius.circular(radius)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(
                                4, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(padding), child: child))))
        ]));
  }
}

// TITLE COLOURED BOX
class TitleColouredBox extends StatelessWidget {
  final List<Widget> widgets;
  final double height;

  const TitleColouredBox(
      {super.key, required this.widgets, required this.height});

  @override
  Widget build(BuildContext context) {
    return ColouredBox(
        height: height,
        width: MediaQuery.of(context).size.width,
        padding: 10.0,
        colour: superLightCyan,
        radius: 10.0,
        outerPadding: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ));
  }
}

// FORMAT FOR PAGES WITH TITLES
class TitlePageFormat extends StatelessWidget {
  final List<Widget> children;

  const TitlePageFormat({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(children: [
              const Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: SizedBox(
                    height: 80,
                  )),
              Flexible(
                  flex: 12,
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children)))
            ])));
  }
}

// DATE FIELD
class DiaryDateField extends StatefulWidget {
  const DiaryDateField(
      {super.key,
      required this.width,
      required this.height,
      required this.getDateFunc,
      required this.updateDateFunc});

  final double width;
  final double height;
  final ValueGetter<DateTime> getDateFunc;
  final ValueSetter<DateTime> updateDateFunc;

  @override
  State<StatefulWidget> createState() => _DiaryDateFieldState(
      width: width,
      height: height,
      getDateFunc: getDateFunc,
      updateDateFunc: updateDateFunc);
}

class _DiaryDateFieldState extends State<DiaryDateField> {
  _DiaryDateFieldState({
    required this.getDateFunc,
    required this.updateDateFunc,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  final ValueGetter<DateTime> getDateFunc;
  final ValueSetter<DateTime> updateDateFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: DateTimeFormField(
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.edit_calendar),
          ),
          onDateSelected: (DateTime value) {
            updateDateFunc(value);
          },
          dateFormat: DateFormat.yMd(),
          initialValue: getDateFunc(),
          mode: DateTimeFieldPickerMode.date,
    ));
  }
}

// EACH ROW TO HIDE MEDICAL INFORMATION
class VisibilityTile extends StatefulWidget {
  const VisibilityTile({super.key, required this.data, required this.editMode});
  final HealthcareHistoryDataEntry data;
  final bool editMode;

  @override
  State<StatefulWidget> createState() => _VisibilityTileState(data, editMode);
}

class _VisibilityTileState extends State<VisibilityTile> {
  HealthcareHistoryDataEntry _data;

  _VisibilityTileState(this._data, this.editMode);

  bool visible = true;
  bool editMode;

  @override
  Widget build(BuildContext context) {
    if (idToHospVisitDet[_data.id] == null) {
      idToHospVisitDet[_data.id] = HospitalVisitDetailsPage(id: _data.id);
    }
    List<Flexible> moreInfo = editMode
        ? []
        : [
            Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Container(
                    width: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: EdgeInsets.all(3),
                        textStyle: boldContent,
                        backgroundColor: lightGrey,
                        foregroundColor: Colors.black,
                        elevation: 10,
                        minimumSize: const Size(100, 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  idToHospVisitDet[_data.id]!),
                        );
                      },
                      child: Text(
                        'More Info',
                        textAlign: TextAlign.center,
                      ),
                    ))),
          ];
    Widget widget = ColouredBox(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        padding: 10.0,
        colour: editMode ? (visible ? contentCyan : unselectGrey) : contentCyan,
        child: Row(
            children: [
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 4,
                      child: Container(
                          width: 50,
                          child: DefaultTextStyle(
                            child: Text(_data.admissionDate),
                            style: content,
                            softWrap: true,
                          ))),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 7,
                      child: Container(
                          width: 250,
                          padding: EdgeInsets.only(left: 15),
                          child: DefaultTextStyle(
                            child: Text(_data.summary),
                            style: content,
                            softWrap: true,
                          )))
                ] +
                moreInfo),
        radius: 0,
        outerPadding: 0);
    Widget visIcon = IconButton(
        onPressed: () {
          setState(() {
            visible = false;
            toHide.add(_data.id);
          });
        },
        icon: Icon(Icons.visibility));
    Widget nonVisIcon = IconButton(
        onPressed: () {
          setState(() {
            visible = true;
            toHide.remove(_data.id);
          });
        },
        icon: Icon(Icons.visibility_off));
    if (editMode) {
      return Row(children: [
        Flexible(flex: 2, child: visible ? visIcon : nonVisIcon),
        SizedBox(
          width: 10,
        ),
        Flexible(flex: 20, child: widget),
      ]);
    }
    return widget;
  }
}

// ADD BUTTON
class AddInfoButton extends StatelessWidget {
  const AddInfoButton(
      {super.key,
      required this.nextPage,
      required this.width,
      required this.height});
  final Widget nextPage;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          textStyle: boldContent,
          backgroundColor: buttonCyan,
          foregroundColor: Colors.white,
          elevation: 10,
          minimumSize: Size(width, height),
          padding: EdgeInsets.zero),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: const Text('Add Entry'),
    );
  }
}

// GENERAL TILE FOR TWO INFORMATION
class TwoInfoTile extends StatelessWidget {
  const TwoInfoTile(
      {super.key, required this.data1, required this.data2, required this.id});

  final String data1;
  final String data2;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ColouredBox(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      padding: 10.0,
      colour: contentCyan,
      radius: 0,
      outerPadding: 0,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 10,
            child: Container(
              width: 50,
              child: DefaultTextStyle(
                style: content,
                softWrap: true,
                child: Text(data1),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 25,
            child: Container(
              width: 250,
              padding: const EdgeInsets.only(left: 15),
              child: DefaultTextStyle(
                style: content,
                softWrap: false,
                child: Text(
                  data2,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ADD * BEHIND REQUIRED FIELDS
Widget requiredField(String title, String isRequired) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: title,
          style: boldContent,
        ),
        TextSpan(
          text: isRequired,
          style: const TextStyle(fontSize:15, color: Colors.red),
        ),
        TextSpan(
          text: ':',
          style: boldContent,
        ),
      ],
    ),
  );
}
