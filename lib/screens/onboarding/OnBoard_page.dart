import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../MainScreen.dart';
import 'Model.dart';
import 'package:permission_handler/permission_handler.dart';

class OnBoard_Page extends StatefulWidget {
  final OnBoardPageModel pageModel;
  final PageController pageController;

  const OnBoard_Page(
      {Key key, @required this.pageModel, @required this.pageController})
      : super(key: key);

  @override
  _OnBoard_PageState createState() => _OnBoard_PageState();
}

class _OnBoard_PageState extends State<OnBoard_Page> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          new Image.asset(widget.pageModel.imagePath),
          Padding(
            padding: EdgeInsets.only(top: height * 0.05),
            child: Text(
              widget.pageModel.heading,
              style: TextStyle(
                  fontSize: 45.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Sans'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.0362, left: width * 0.07, right: width * 0.05),
            child: Text(
              widget.pageModel.subHead,
              style: TextStyle(
                  fontSize: 17.0,
                  wordSpacing: 1.5,
                  color: Colors.black,
                  fontFamily: 'Sans'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.0462, left: width * 0.07, right: width * 0.05),
            child: Text(
              widget.pageModel.desc,
              style: TextStyle(
                  fontFamily: 'Sans',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: height * 0.04, left: width * 0.07, right: width * 0.05),
            child: FloatingActionButton(
              elevation: 4.0,
              backgroundColor: Colors.blue,
              child: Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (widget.pageModel.pageNumber == 1) {
                 
                  widget.pageController.nextPage(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 1000),
                  );
                } else if (widget.pageModel.pageNumber == 2) {
                  
                  
                    SystemChrome.setEnabledSystemUIOverlays(
                        SystemUiOverlay.values);
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        builder: (context) => new MainScreen()));
                  }
                }
              ,
            ),
          ),
        ],
      ),
    );
  }
}
