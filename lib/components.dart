import 'dart:ui';

import 'package:flutter/material.dart';
import 'colours.dart' as colours;
import 'fonts.dart' as fonts;
import 'pages.dart' as pages;

// MEDICAL INST WITH ACCESS LOGO
// At top right coirner of home page
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

// Long Buttons
class LongButton extends StatelessWidget {
  const LongButton({super.key, required this.word, required this.nextPage});

  final String word;
  final Widget nextPage;

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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        },
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

// AUTHENTICATION OVERLAY
class CustomOverlay {
  OverlayEntry? _overlayEntry;
  static late OverlayState overlayState;

  void showOverlay(BuildContext context) {
    overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Center(
          child: OverlayWidget(),);
      },
    );
    print(_overlayEntry);
    overlayState?.insert(_overlayEntry!);
  }

  void hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

// OVERLAY WIDGET
class OverlayWidget extends StatefulWidget {
  const OverlayWidget({super.key});

  @override
  State<StatefulWidget> createState() => _OverlayState();
  
}

class _OverlayState extends State<OverlayWidget> {
  List<bool> _isCheckedList = [false, false];
  List<String> strs = ['I consent to share all medical data to this hospital for treatment '
      'purposes only for 7 days', 'I wish to share selected data only for 7 days'];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: Center(
          child: Material(child: SizedBox(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              child: Padding(padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child:
              DecoratedBox(
                  decoration: BoxDecoration(color: colours.bgGrey,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(4, 8), // changes position of shadow
                      ),
                    ],),
                  child: Padding(padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 35.0, bottom: 35.0),
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
                                  ShortButton(text: 'decline', color: colours.buttonRed,),
                                  ShortButton(text: 'accept', color: colours.buttonGreen,),
                                ]
                              )
                          ]
                        )
                        ]))))
          )
      ),),
    ),
    );
  }
}

// SHORT BUTTON
class ShortButton extends StatelessWidget {
  const ShortButton({super.key, required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: Text(text),
    style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
    elevation: 10,
      minimumSize: const Size(100, 30),),
    );
  }

}