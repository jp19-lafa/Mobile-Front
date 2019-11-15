import 'package:flutter/material.dart';

class FloatingValueBox extends StatelessWidget {
  const FloatingValueBox({this.title, @required this.value, this.suffix = ''});

  final String title;
  final String value;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
            )
          ],
        ),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    value + suffix,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}