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
    return SizedBox(
      width: 124,
      height: 100,
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
                width: 110,
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
