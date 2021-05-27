import 'package:covid_track/resources/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHeader extends StatefulWidget {
  final String image;
  final String textTop;
  final double offset;
  const MyHeader({Key key, this.image, this.textTop, this.offset})
      : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 60, right: 10),
        height: 275,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),
          image: DecorationImage(
            image: AssetImage("assets/virus.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: (widget.offset < 0) ? 0 : widget.offset,
                    child: SvgPicture.asset(
                      widget.image,
                      width: 210,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    top: widget.offset / 2,
                    left: 160,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "${widget.textTop}",
                        style: kHeadingTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 115 - widget.offset / 2,
                  //   left: 180,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       // Text(
                  //       //   "Liên hệ",
                  //       //   style: kSubTextStyle.copyWith(
                  //       //     color: Colors.white,fontWeight: FontWeight.bold
                  //       //   ),
                  //       // ),
                  //       FlatButton.icon(
                  //         // padding: const EdgeInsets.symmetric(
                  //         //   vertical: 10.0,
                  //         //   horizontal: 20.0,
                  //         // ),
                  //         onPressed: () {},
                  //         color: Colors.red,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(30.0),
                  //         ),
                  //         icon: const Icon(
                  //           Icons.phone,
                  //           color: Colors.white,
                  //           size: 15,
                  //         ),
                  //         label: Text(
                  //           'Liên hệ',
                  //           style: TextStyle(fontSize: 12,color: Colors.white,),
                  //         ),
                  //
                  //       ),
                  //     ],
                  //   ),
                  // ),
//                  Container(), // I dont know why it can't work without container
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
