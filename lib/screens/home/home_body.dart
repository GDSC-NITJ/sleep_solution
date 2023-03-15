import 'package:flutter/material.dart';
import 'package:night_gschallenge/widgets/home_screen/news_update.dart';
import 'package:night_gschallenge/widgets/home_screen/reusable_card.dart';
import 'package:night_gschallenge/widgets/home_screen/sleep_score.dart';
import 'package:night_gschallenge/widgets/home_screen/welcome_user.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final calmData = {'title': 'Calm Tunes', 'tunes': [], 'buttonLink': '/Home'};

  final recents = {
    'title': 'Recents Added',
    'tunes': [],
    'buttonLink': '/Home'
  };

  final newsData = {
    'title': 'News Update',
    'news': ['a', 'b', 'c'],
    'buttonLink': '/Home'
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height,maxWidth: MediaQuery.of(context).size.width),
      child: ListView(
        children: [
          WelcomeUser(),
        ],
      ),
    );
  }
}
