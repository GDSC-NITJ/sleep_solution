import 'package:flutter/material.dart';
import 'package:night_gschallenge/screens/menu/WorryList/Steps/step_one.dart';
import 'package:night_gschallenge/screens/menu/WorryList/Steps/step_three.dart';
import 'package:night_gschallenge/widgets/UI/elevated_button_without_icon.dart';
import 'package:night_gschallenge/widgets/UI/menuHeroImage.dart';
import 'package:night_gschallenge/widgets/UI/top_row.dart';

class StepTwo extends StatefulWidget {
  static const routeName = 'menu/steptwo';

  @override
  State<StepTwo> createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> {
  bool isWorryTime = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        TopRow(
          back: true,
        ),
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Theme.of(context).canvasColor,
          ),
          child: Column(children: [
            Text(
              'Managing Worry',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            MenuHeroImage(
              image: 'assets/worry.gif',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Once you have kept a worry diary for a period of time and have got used to classifying your worries, the next step is to manage your worries. ',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Can you do something to your worry right now?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ListTile(
              leading: Icon(
                Icons.check_box,
                color: Colors.green,
                size: 50,
              ),
              title: Text('Yes'),
              subtitle: Text(
                'Make an action plan to solve the worry.',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(
                Icons.close,
                color: Colors.red,
                size: 50,
              ),
              title: Text('No'),
              subtitle: Text('Use worry time to help let it go.'),
            ),
            SizedBox(
              height: 30,
            ),
            if(!isWorryTime)
            Center(
              child: ElevatedButtonWithoutIcon(
                text: 'What is worry time?',
                onPressedButton: (){
                  setState(() {
                    isWorryTime = !isWorryTime;
                  });
                },
              ),
            ),
          ]),
        ),
        if (isWorryTime)
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Theme.of(context).canvasColor,
            ),
            child: Column(children: [
              Text(
                'What is worry time?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Worry time is a set period of time each day allocated to worrying. Worry time can be helpful in reducing the time we spend each day worrying, allowing us to enjoy our day to day lives. When we worry during the day, instead of focusing on these worry we postpone them for our allotted worry time.',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ]),
          ),
        Center(
          child: ElevatedButtonWithoutIcon(
            text: 'Proceed',
            onPressedButton: () {
              Navigator.of(context).pushNamed(StepThree.routeName);
            },
          ),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    ));
  }
}