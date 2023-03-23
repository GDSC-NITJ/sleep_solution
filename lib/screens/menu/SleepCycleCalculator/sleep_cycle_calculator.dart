import 'package:flutter/material.dart';
import 'package:night_gschallenge/widgets/UI/InformativeText.dart';
import 'package:night_gschallenge/widgets/UI/TimeContainer.dart';
import 'package:night_gschallenge/widgets/UI/elevated_button_without_icon.dart';
import 'package:night_gschallenge/widgets/UI/home_screen_heading.dart';
import 'package:night_gschallenge/widgets/UI/menuHeroImage.dart';
import 'package:night_gschallenge/widgets/UI/time_boxes.dart';
import 'package:night_gschallenge/widgets/UI/time_little_box.dart';
import 'package:night_gschallenge/widgets/UI/top_row.dart';

class SleepCycleCalculator extends StatefulWidget {
  static const routeName = 'menu/sleepcyclecalculator';

  @override
  State<SleepCycleCalculator> createState() => _SleepCycleCalculatorState();
}

class _SleepCycleCalculatorState extends State<SleepCycleCalculator> {
  List<Map<String, dynamic>> _data = [];
  int averageSleepCycle = 90;
  TimeOfDay startDate = TimeOfDay.now();
  bool data = false;
  bool settingsOn = false;
  int timeTakenToFallAsleep = 15;

  void calculateResults() {
    _data.clear();
    int sleepCycles = 6;
    int startDateMinutes = startDate.hour * 60 + startDate.minute;

    int sleepTime = sleepCycles * averageSleepCycle;

    while (sleepCycles >= 3) {
      var wakeup = ((startDateMinutes + timeTakenToFallAsleep + 
                  sleepCycles * averageSleepCycle) /
              60) %
          12;
      var minutes = (startDateMinutes + timeTakenToFallAsleep +
              sleepCycles * averageSleepCycle) %
          60;
      var meridian = ((startDateMinutes +
                      sleepCycles * averageSleepCycle) /
                  60) >
              12
          ? 'PM'
          : 'AM';
      _data.add({
        'wakeup':
            '${wakeup.floor()}:${minutes.toString().length < 2 ? '0' : ''}${minutes} $meridian',
        'hours': ((sleepCycles * averageSleepCycle) / 60).toStringAsFixed(1),
        'cycles': sleepCycles,
        'recommended': false,
      });

      sleepCycles--;
    }

    _data[0]['recommended'] = true;

    setState(() {
      data = true;
      settingsOn = false;
    });
  }

  void onTapClear() {
    _data.clear();
    setState(() {
      data = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TopRow(
            back: true,
          ),
          HomeScreenText(
            text: 'Sleep Cycle Calculator',
          ),
          MenuHeroImage(
            image: 'assets/sleepcyclecalculator.gif',
          ),
          InformativeText(
            text:
                'Track different stages of your sleep and wake up during your lightest stage',
            icon: Icons.sunny,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'I plan to go bed at...',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                TimeBoxes(
                  hours: startDate.hour > 12
                      ? (startDate.hour - 12).toString()
                      : (startDate.hour).toString(),
                  minutes: startDate.minute.toString(),
                  meridian: startDate.hour > 12 ? 'PM' : 'AM',
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: startDate,
                    ).then((pickedDate) {
                      setState(() {
                        startDate = pickedDate!;
                      });
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButtonWithoutIcon(
                      text: 'Submit',
                      onPressedButton: calculateResults,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButtonWithoutIcon(
                      text: 'Settings',
                      onPressedButton: () {
                        setState(() {
                          settingsOn = true;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          if (settingsOn)
            Column(
              children: [
                HomeScreenText(
                  text: 'Settings',
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Average sleep cycle length is 90 minutes'
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'My sleep cycle length is : ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).canvasColor,
                        ),
                        onChanged: (value) {
                          averageSleepCycle = int.parse(value);
                        },
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'minutes ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Time I take to fall asleep : ',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).canvasColor,
                        ),
                        onChanged: (value) {
                          timeTakenToFallAsleep = int.parse(value);
                        },
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'minutes ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButtonWithoutIcon(
                  text: 'Done',
                  onPressedButton: () {
                    setState(() {
                      data = false;
                      settingsOn = false;
                    });
                  },
                )
              ],
            ),
          SizedBox(
            height: 20,
          ),
          if (data && !settingsOn)
            Text(
              'If you go to bed at ${startDate.hour}:${startDate.minute} ${startDate.hour > 12 ? 'PM' : 'AM'}, you should try to put alarm at one of the following times: ',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
          SizedBox(
            height: 20,
          ),
          if (data && !settingsOn) TimeContainer(_data, onTapClear),
        ],
      ),
    );
  }
}