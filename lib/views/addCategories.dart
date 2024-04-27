import 'package:flutter/material.dart';
import '../Database/My_DB.dart';

class addCategories extends StatefulWidget {
  const addCategories({super.key});

  @override
  State<addCategories> createState() => _addCategoriesState();
}

class _addCategoriesState extends State<addCategories> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  privateDB private_db = new privateDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insert Data"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "Enter product name : "),
          ),
          SizedBox(height: 16),
          TextField(
            controller: priceController,
            decoration: InputDecoration(hintText: "Enter product price : "),
          ),
          SizedBox(height: 20),
          Container(
              width: 150,
              child: MaterialButton(
                child: Text(
                  "ADD",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                color: Colors.blue,
                textColor: Colors.black,
                splashColor: const Color.fromARGB(255, 233, 119, 111),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () async {
                  // save to database
                  int price = int.parse(priceController.text);
                  int response =
                      await private_db.insertData(nameController.text, price);

                  // show snakebar
                  var snackBar = new SnackBar(
                    content: Text("${nameController.text} is added"),
                    duration: Duration(milliseconds: 3000),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  // back to homepage
                  Navigator.of(context).pop();
                },
              )),
        ],
      ),
    );
  }
}
