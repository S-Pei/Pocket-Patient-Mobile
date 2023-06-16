import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/diaryCategoryPage.dart';
import 'colours.dart';
import '../pages/hospitalVisitPage.dart';
import '../pages/medicationPage.dart';
import '../pages/medicalHistoryPage.dart';

// NAV BAR
class InfoPage extends StatefulWidget {
  final int selectedIndex;
  const InfoPage({super.key, required this.selectedIndex});

  @override
  State<StatefulWidget> createState() => _InfoPageState(selectedIndex);
}

class _InfoPageState extends State<InfoPage> {
  late int _selectedIndex;
  _InfoPageState(int selectedIndex) {
    _selectedIndex = selectedIndex;
  }

  final List<Widget> _pages = [
    const MedicationPage(),
    const MedicalHistoryPage(),
    const HospitalVisitPage(),
    const DiaryCategoryPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
            decoration: BoxDecoration(color: mainCyan),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavBarElem(
                    text: 'Medications',
                    icon: Icons.vaccines,
                    selected: _selectedIndex == 0,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    index: 0,
                  ),
                  NavBarElem(
                    text: 'My Medical History',
                    icon: Icons.medical_information,
                    selected: _selectedIndex == 1,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    index: 1,
                  ),
                  NavBarElem(
                    text: 'Hospital Visit History',
                    icon: Icons.local_hospital,
                    selected: _selectedIndex == 2,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    index: 2,
                  )
                ],
              )),
          )
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
          color: mainCyan,
          border: Border(
            left: index == 0
                ? BorderSide.none
                : BorderSide(width: 5.0, color: lightCyan),
            right: index == 2
                ? BorderSide.none
                : BorderSide(width: 5.0, color: lightCyan),
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