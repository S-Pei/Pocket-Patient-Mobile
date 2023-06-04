import 'package:flutter/material.dart';
import 'colours.dart' as colours;
import 'fonts.dart' as fonts;

// HOME PAGE
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Icon Example'),
        // ),
        body: Stack(
          children: [
            Center(
              child: 
                Container(
                  padding: EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:150,),
                      Text('Bob Choy', style: fonts.title, softWrap: true),
                      InfoFormat(title: 'NHS Number', info:'123 456 7890'),
                      InfoFormat(title: 'D.O.B', info: '29 Feb 1983'),
                      InfoFormat(title: 'Address', info: '12, Smith Road, AB 321 London'),
                      SizedBox(height:50,),
                      LongButton(word: 'My Prescriptions'),
                      SizedBox(height:50,),
                      LongButton(word: 'My Medical History'),
                      SizedBox(height:50,),
                      LongButton(word: 'Hospital Visit History'),
                    ]
                  )
                )
            ),
            
            MedInsAccLogo(),
            HomeIcon(),
          ],
        ),
      );
  }
  const HomePage({super.key});

  // @override
  // State<HomePage> createState() => _HomePageState();
}



// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// MEDICAL INST WITH ACCESS LOGO
// At top right coirner of home page
class MedInsAccLogo extends StatelessWidget {
  const MedInsAccLogo({super.key});
  
  @override
  Widget build(BuildContext context) {
    return 
        Positioned(
            top: 60.0,
            right: 20.0,
            child: 
                Container(
                width:80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                // color: const Color(0xa1dade),
                color: colours.mainCyan,
                borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                        Icons.apartment,
                        size: 40.0,
                        color: Colors.black,
                        ),
                 )
    );
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
              child: Icon(
                Icons.home,
                size: 40.0,
                color: Colors.black,
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
      overflow: TextOverflow.clip,
      softWrap: true,
      TextSpan(
        text: '$title: ',
        style: fonts.subtitle,
        children:<TextSpan> [
          TextSpan(text: info, style: fonts.info)
        ]
      ),
    );
  }
}

// Long Buttons
class LongButton extends StatelessWidget {
  const LongButton({super.key, required this.word});

  final String word;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 350,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),textStyle: fonts.subtitle, backgroundColor: colours.buttonCyan, foregroundColor: Colors.white),
          onPressed: () {},
          child: Text(word),
        ),
    );
  }
}
