import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:night_gschallenge/providers/count_down_provider.dart';
import 'package:night_gschallenge/providers/screen_brightness_provider.dart';
import 'package:night_gschallenge/screens/menu/PhoneFreeTime/phone_free_time.dart';
import 'package:provider/provider.dart';
import 'package:volume_controller/volume_controller.dart';

class ZenScreen extends StatefulWidget {

  static String routeName ='/zen-screen';
  double currBrightness=0;
  @override
  State<ZenScreen> createState() => _ZenScreenState();
}

class _ZenScreenState extends State<ZenScreen> {
  @override
  Widget build(BuildContext context) {
    var brightnessProvider=Provider.of<ScreenBrightnessProvider>(context,listen: false);
    brightnessProvider.currentBrightness.then((value) => widget.currBrightness=value);
    brightnessProvider.setBrightness(0);
    VolumeController().setVolume(0);
    final args = ModalRoute.of(context)!.settings.arguments;
    var controller = Provider.of<CountDownProvider>(context).controller;
    return WillPopScope(
      onWillPop: ()async {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('You are in Zen Mode Wait for '),Expanded(child: ElevatedButton(onPressed: (){
          VolumeController().setVolume(100);
          brightnessProvider.setBrightness(widget.currBrightness).then((value) {
          Navigator.of(context).popUntil(ModalRoute.withName(PhoneFreeTime.routeName));


          });
          }, child: Text('Exit Mode',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),)),],) ));
        return false;
      },
      child: Scaffold(
        body: Center(
          child: NeonCircularTimer(
            onComplete: (){
              brightnessProvider.resetBrightness();
              VolumeController().setVolume(100);
              Navigator.of(context).pop();
            },
            controller: controller,
            textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 37,color: Colors.white),
            isTimerTextShown: true,
            neumorphicEffect: true,
            duration: (args as int)*60,
            innerFillGradient: LinearGradient(colors: [
            Colors.greenAccent.shade200,
            Colors.blueAccent.shade400
          ]),
          backgroudColor: Colors.black,
          neonGradient: LinearGradient(colors: [
            Color.fromRGBO(255, 255, 255, 1),
            Color.fromRGBO(143, 227, 221, 1)
          ]),
            width: 250,
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}