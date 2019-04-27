import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:portraits/screens/fullscreen.dart';

class Wallpapers extends StatefulWidget {
  /* Any variable declarations will be declared here... */
  /* And declare variables which has to get the values from the previous activity, 
  these are just like params in a simple functions. */

  @override
  _WallpapersState createState() => _WallpapersState();
}

class _WallpapersState extends State<Wallpapers> {
  /* Any variable declarations will be declared here... */

  @override
  Widget build(BuildContext context) =>
      /* Scaffold is a widget which creates a material design visual layout structure.
  This class provides APIs for showing drawers, snack bars, and bottom sheets. */
      Scaffold(
        // AppBar which shows the AppBar at the top of the scaffold which takes title, menuItems, drawers and more.
        appBar: AppBar(
          title: Text('Portraits'),
          backgroundColor: Color.fromRGBO(9, 9, 26, 1.0),
        ),
        backgroundColor: Color.fromRGBO(9, 9, 26, 1.0),
        // body declares your body of the app screen
        body: wallurls(context, wallpapersList),
      );

  // initState() function runs as soon as app enters this activity.
  @override
  void initState() {
    super.initState();
    firestore();
  }

  // dispose() function runs as soon as app exits this activity and disposes all your subscription and Future tasks.
  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  /*
    The subscription provides events to the listener, 
    and holds the callbacks used to handle the events. 
    The subscription can also be used to unsubscribe from the events, 
    or to temporarily pause the events from the stream.
  */
  StreamSubscription<QuerySnapshot> subscription;

  // List – An indexable collection of objects with a length.
  List<DocumentSnapshot> wallpapersList;

  // Declares a function which does not return anything

  void firestore() async {
    final Firestore firestore = Firestore();
    await firestore.settings(
        timestampsInSnapshotsEnabled: true, persistenceEnabled: false);
    final CollectionReference collectionReference =
        firestore.collection('portraits');
    subscription = collectionReference.snapshots().listen((datasnapshot) =>
        setState(() => wallpapersList = datasnapshot.documents));
  }

  // Declared a function of type Widget –>
  Widget wallurls(BuildContext context, List<DocumentSnapshot> wallList) => wallList !=
          null
      // GridView -> Creates a scrollable, 2D array of widgets with a fixed number of tiles in the cross axis.
      // `?` means if and `:` means else
      ? GridView.count(
          crossAxisCount: 2,
          childAspectRatio: .64,
          shrinkWrap: false,
          // List -> Creates a scrollable, 2D array of widgets with a fixed number of tiles in the cross axis.
          children: List.generate(
              wallList.length,
              (index) => Container(
                      // InkWell -> Gives a tap functionality to your widget
                      child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreen(wallList[index].data['url']),
                        )),
                    child: Hero(
                      tag: wallList[index].data['id'],
                      child: FadeInImage(
                        image: NetworkImage(wallList[index].data['url']),
                        fit: BoxFit.cover,
                        placeholder: AssetImage('portraits_placeholder.webp'),
                      ),
                    ),
                  ))))
      : Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        );
}
