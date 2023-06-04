import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:core';
import 'colours.dart' as colours;
import 'objects.dart' as objects;
import 'components.dart' as widgets;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient On Call',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const widgets.HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  static Future<objects.Patient> getData() async {
    var response = await http.get(
      Uri.parse('https://patientoncall.herokuapp.com/api/patient-data/')
    );
    print(response);
    
    if (response.statusCode == 200) {
      print(response.body);
      return objects.Patient.fromJson(json.decode(response.body));
    } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
  }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final ButtonStyle buttonStyle =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  TextEditingController dateController = TextEditingController();
  TextEditingController summaryController = TextEditingController();

  Future<void> postData() async {
    final response = await http.post(
      Uri.parse('https://patientoncall.herokuapp.com/api/patient-data/medical-history/'),
      body: json.encode({
        'date': dateController.text,
        'summary': summaryController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Data successfully posted
      print('Data posted successfully');
    } else {
      // Handle error if the request fails
      print('Failed to post data');
    }
  }

  objects.Patient? fetchedData;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://patientoncall.herokuapp.com/api/patient-data/'));
    
    if (response.statusCode == 200) {
      setState(() {
        fetchedData = objects.Patient.fromJson(json.decode(response.body));
      });
    } else {
      // Handle error if the request fails
      print('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }
  
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Column(
      children: <Widget>[
    SizedBox(
      height: 50,
    ),
    Center(
      child: Text(
        'My Medical History',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
    ),
    Text('Date'),
    Row(
        children: [
          Expanded(
            child: Text('Date')
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: Text('history',
            style: TextStyle(
            backgroundColor: Colors.grey))
          ),
        ],
      ),
    // SizedBox(
    //   width: 350,
    //   height:400,
    // ),
    SizedBox(
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
        onPressed: null,
        child: Text('Get Medical History'),
      )
    ),    
  ],
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void refreshData() {
    print(dateController.text);
    print(summaryController.text);
    postData().then((_) {fetchData();});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient On Call'),
      ),
      body: 
      Column(
        children: [Text(fetchedData.toString()),
          ListTile(
      title: Text('Date'),
      subtitle: TextFormField(
        controller: dateController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          hintText: 'Date',
        ),
      ),
    ),
    ListTile(
      title: Text('Summary'),
      subtitle: TextFormField(
        controller: summaryController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          hintText: 'Summary',
        ),
      ),
    ),
      SizedBox(
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
        onPressed: refreshData,
        child: Text('Add Medical History'),
      )
    ), ]
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vaccines),
            label: 'Prescriptions',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: 'Medical History',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Hospital Visit History',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}




