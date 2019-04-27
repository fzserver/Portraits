import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FullScreen extends StatefulWidget {
  final String imgPath;
  FullScreen(this.imgPath);

  /* Any variable declarations will be declared here... */
  /* And declare variables which has to get the values from the previous activity, 
  these are just like params in a simple functions. */

  @override
  FullScreenState createState() => new FullScreenState();
}

class FullScreenState extends State<FullScreen> {
  /* Any variable declarations will be declared here... */

  @override
  Widget build(BuildContext context) =>
      /* Scaffold is a widget which creates a material design visual layout structure.
  This class provides APIs for showing drawers, snack bars, and bottom sheets. */
      Scaffold(
          // AppBar which shows the AppBar at the top of the scaffold wich takes title, menuItems, drawers and more.
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // body declares your body of the app screen
          body: Stack(fit: StackFit.expand, children: <Widget>[
            FadeInImage(
              image: NetworkImage(widget.imgPath),
              fit: BoxFit.cover,
              placeholder: AssetImage('portraits_placeholder.webp'),
            )
          ]));
}
