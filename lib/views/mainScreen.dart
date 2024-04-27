import 'package:flutter/material.dart';

class mainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 235,
                child: MaterialButton(
                  child: Text(
                    "Add Category",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  color: Colors.blue,
                  textColor: Colors.black,
                  splashColor: const Color.fromARGB(255, 233, 119, 111),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    // go to add Cat.. page
                    Navigator.of(context).pushNamed("addCat");
                  },
                )),
            Container(
              width: 235,
              child: MaterialButton(
                child: Text(
                  "Show Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                color: Colors.blue,
                textColor: Colors.black,
                splashColor: const Color.fromARGB(255, 233, 119, 111),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  // go to show Cat.. page
                  Navigator.of(context).pushNamed("showCat");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
