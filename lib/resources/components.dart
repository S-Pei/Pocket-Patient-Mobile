import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/profilePage.dart';
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
            icon: const Icon(Icons.account_circle, size: 40.0,),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );},
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

// Long Buttons to navigate to another page
class NavigateShortButton extends StatelessWidget {
  const NavigateShortButton({super.key, required this.word, required this.nextPage});

  final String word;
  final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return ShortButton(word: word,
        onPress: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );},);
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
      child: GeneralButton(word: word, onPress: onPress, length: 350, style: subtitle,)
    );
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
        child: GeneralButton(word: word, onPress: onPress, length: 150, style: boldContent,)
    );
  }
}

// GENERAL BUTTON
class GeneralButton extends StatelessWidget {
  const GeneralButton({super.key, required this.word, required this.onPress, required this.length, required this.style});

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
        child: Text(word, softWrap: true, textAlign: TextAlign.center,),
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
  OverlayEntry? _prevOverlayEntry;

  void showOverlay(BuildContext context, Widget toShow) {
    overlayState = Overlay.of(context);
    if (_overlayEntry != null) {
      _prevOverlayEntry = _overlayEntry;
    }
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Center(
          child: toShow,);
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
  const SmallButton({super.key, required this.text, required this.color, required this.onPress});
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
    return Container(
      alignment: Alignment.center,
        child: Column(children: [SizedBox(
        // height: height,
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
    )]));
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
              Flexible(flex: 2,
                  fit: FlexFit.tight,
                  child: SizedBox(
                    height: 80,
                  )),
              Flexible(flex: 12,
                  child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children
                      )
                  )
              )]
            )
        )
    );
  }

}