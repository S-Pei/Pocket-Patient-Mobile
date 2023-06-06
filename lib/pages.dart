import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'components.dart';
import 'fonts.dart' as fonts;
import 'colours.dart' as colours;

// HOME PAGE
class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String message = 'No message received';

  final channel = WebSocketChannel.connect(
    Uri.parse('wss://patientoncall.herokuapp.com/ws/patientoncall/'),
  );

  @override
  void initState() {
    super.initState();
    channel.sink.add('Hello!');
    channel.stream.listen((data) {
      setState(() {
        message = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Container(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text('Bob Choy', style: fonts.title, softWrap: true),
                        InfoFormat(title: 'NHS Number', info: '123 456 7890'),
                        InfoFormat(title: 'D.O.B', info: '29 Feb 1983'),
                        InfoFormat(
                            title: 'Address',
                            info: '12, Smith Road, AB 321 London'),
                        SizedBox(
                          height: 50,
                        ),
                        LongButton(
                            word: 'My Prescriptions',
                            nextPage: InfoPage(selectedIndex: 0)),
                        SizedBox(
                          height: 50,
                        ),
                        LongButton(
                            word: 'My Medical History',
                            nextPage: InfoPage(selectedIndex: 1)),
                        SizedBox(
                          height: 50,
                        ),
                        LongButton(
                            word: 'Hospital Visit History',
                            nextPage: InfoPage(selectedIndex: 2)),
                        ElevatedButton(onPressed: () {CustomOverlay().showOverlay(context);}, child: Text('show overlay')),
                      Text(message),]))),
          const MedInsAccLogo(),
          const HomeIcon(),
        ],
      ),
    );
  }
}

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
    const PrescriptionPage(),
    const MedicalHistoryPage(),
    const HospitalVisitPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
            decoration: BoxDecoration(color: colours.mainCyan),
            child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NavBarElem(
                      text: 'Prescriptions',
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
          )),
    );
  }
}

// PRESCRIPTION PAGE
class PrescriptionPage extends StatelessWidget {
  const PrescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Container(
                  padding: const EdgeInsets.all(50.0),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Row(children: [
                          Text('Prescriptions', style: fonts.subtitle),
                          Expanded(child: SizedBox(width: 70)),
                          PrintButton(),
                        ]),
                      ]))),
          const HomeIcon(),
        ],
      ),
    );
  }
}

// MEDICAL HISTORY PAGE
class MedicalHistoryPage extends StatelessWidget {
  const MedicalHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Medical History Page'),
      ),
    );
  }
}

// MEDICAL HISTORY PAGE
class HospitalVisitPage extends StatelessWidget {
  const HospitalVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hospital Visit History Page'),
      ),
    );
  }
}
