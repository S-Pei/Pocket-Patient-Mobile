import 'package:flutter/material.dart';
import 'colours.dart';
import 'fonts.dart';
import '../pages/homePage.dart';
import 'globals.dart';

// MEDICAL INST WITH ACCESS LOGO
// At top right corner of home page
// class MedInsAccLogo extends StatelessWidget {
//   const MedInsAccLogo({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//         top: 60.0,
//         right: 20.0,
//         child: Container(
//           width: 80,
//           height: 80,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             // color: const Color(0xa1dade),
//             color: mainCyan,
//             borderRadius: BorderRadius.circular(50),
//           ),
//           child: const Icon(
//             Icons.apartment,
//             size: 40.0,
//             color: Colors.black,
//           ),
//         ));
//   }
// }

// HOME ICON
class HomeIcon extends StatelessWidget {
  const HomeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90.0,
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
      TextSpan(
          text: '$title: ',
          style: subtitle,
          children: <TextSpan>[TextSpan(text: info, style: infoFont,)]),
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
      height: 60,
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            textStyle: subtitle,
            backgroundColor: buttonCyan,
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
    print('overlay: ${_overlayEntry}');
    _overlayEntry?.remove();
    _overlayEntry = null;
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

// TITLE COLOURED BOX
class TitleColouredBox extends StatelessWidget {
  final List<Widget> widgets;
  final double height;

  const TitleColouredBox({super.key, required this.widgets, required this.height});

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