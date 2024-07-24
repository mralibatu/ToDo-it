import 'package:flutter/material.dart';
import 'package:introduction_slider/introduction_slider.dart';
import 'package:todo_it/app/screens/main/main_view.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionSlider(
      items: [
        const IntroductionSliderItem(
          backgroundImageDecoration: BackgroundImageDecoration(
              image: AssetImage("assets/images/thank_you.png"),
            fit: BoxFit.cover
          ),
          gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.indigo,
            ],
          ),
        ),
        IntroductionSliderItem(
          title: AspectRatio(
            aspectRatio: 0.7,
              child: Image.asset("assets/gifs/change_month.gif")),
          gradient: const LinearGradient(
            colors: [
              Colors.cyan,
              Colors.indigo,
            ],
          ),
        ),
        IntroductionSliderItem(
          title: AspectRatio(
              aspectRatio: 0.7,
              child: Image.asset("assets/gifs/toggle_date.gif")),
          gradient: const LinearGradient(
            colors: [
              Colors.cyan,
              Colors.indigo,
            ],
          ),
        ),
        IntroductionSliderItem(
          title: AspectRatio(
              aspectRatio: 0.7,
              child: Image.asset("assets/gifs/main_page.gif")),
          gradient: const LinearGradient(
            colors: [
              Colors.cyan,
              Colors.indigo,
            ],
          ),
        ),
        IntroductionSliderItem(
          title: AspectRatio(
              aspectRatio: 0.7,
              child: Image.asset("assets/gifs/create_task.gif")),
          gradient: const LinearGradient(
            colors: [
              Colors.cyan,
              Colors.indigo,
            ],
          ),
        ),
      ],
      done: const Done(
          child: Icon(Icons.done, color: Colors.white,),
          animationDuration: Duration(seconds: 2),
          home: Main()),
      next: const Next(child: Icon(Icons.arrow_forward_ios, color: Colors.white,)),
      back: const Back(child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
      showStatusBar: true,
      dotIndicator: const DotIndicator(),
    );
  }
}
