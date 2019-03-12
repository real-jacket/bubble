import './bubble.dart';
import 'package:flutter/material.dart';
// import 'package:animated_background/animated_background.dart';
import './imgAnimation.dart';
import 'package:flutter/cupertino.dart';
import './heroAnimation.dart';
import './avatar_bubble.dart';
import './animation_demo.dart';
import './staggerAnimation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bubbles',
      home: HomePage(),
      routes: {
        'bubble': (context) => Scaffold(
              appBar: AppBar(
                title: Text('bubble'),
              ),
              body: Bubbles(),
            ),
        'img': (context) => Scaffold(
              appBar: AppBar(
                title: Text('imgAnimation'),
              ),
              body: Center(
                child: ScaleAnimationRoute(),
              ),
            ),
        'animation': (context) => Scaffold(
          appBar: AppBar(
            title: Text('Animation　Demo'),
          ),
          body: Center(
            child: LogoApp(),
          ),
        ),
        'avatar': (context) => Scaffold(
          appBar: AppBar(
            title: Text('avatar bubble'),
          ),
          body: Center(
            child: BubbleDemo(),
          ),
        )
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('animationDmeo'),
              onPressed: () {
                Navigator.pushNamed(context, 'animation');
              },
            ),
            FlatButton(
              child: Text('bubble'),
              onPressed: () {
                Navigator.pushNamed(context, 'bubble');
              },
            ),
            FlatButton(
              child: Text('imgAnimation'),
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(microseconds: 500),
                        pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: Scaffold(
                              appBar: AppBar(
                                title: Text('imgAnimation'),
                              ),
                              body: Center(
                                child: ScaleAnimationRoute(),
                              ),
                            ),
                          );
                        }));
              },
            ),
            FlatButton(
              child: HeroAnimationRoute(),
              onPressed: () {},
            ),
            FlatButton(
              child: StaggerDemo(),
              onPressed: () {},
            ),
           FlatButton(
              child: Text('avatar'),
              onPressed: () {
                Navigator.pushNamed(context, 'avatar');
              },
            ),
          ],
        ),
      ),
    );
  }
}
// class Bubbles extends StatefulWidget {
//   Bubbles({Key key}) : super(key: key);

//   @override
//   _BubblesState createState() => _BubblesState();
// }

// class _BubblesState extends State<Bubbles> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('bubble demo'),
//       ),
//       body: AnimatedBackground(
//         behaviour: RandomParticleBehaviour(
//           options: ParticleOptions(
//               particleCount: 20,
//               image: Image.asset('assets/images/avatar.png'),
//               spawnMaxSpeed: 30,
//               spawnMinSpeed: 20,
//               ),
//           paint: particlePaint,
//         ),
//         vsync: this,
//         child: ScaleAnimationRoute(),
//       ),
//     );
//   }
// }

// var particlePaint = Paint()
//   ..style = PaintingStyle.stroke
//   ..strokeWidth = 1.0;

