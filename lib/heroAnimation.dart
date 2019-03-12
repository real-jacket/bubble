import 'package:flutter/material.dart';

// HERO动画
class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: InkWell(
        child: Hero(
          tag: "avatar", // 唯一标记，前后两个路由页面的tag必需相同
          child: ClipOval(
            child: Image.asset(
              "assets/images/avatar.png",
              width: 50.0,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, PageRouteBuilder(pageBuilder:
              (BuildContext context, Animation animation,
                  Animation scondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("原图"),
                ),
                body: HeroAnimationRouteB(),
              ),
            );
          }));
        },
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
        child: Image.asset("assets/images/avatar.png"),
      ),
    );
  }
}