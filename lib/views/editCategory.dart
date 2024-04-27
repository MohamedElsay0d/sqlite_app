import 'package:flutter/material.dart';
import '../Database/My_DB.dart';

class editPage extends StatefulWidget {
  final int itemId;

  editPage(this.itemId);

  @override
  _editPageState createState() => _editPageState();
}

class _editPageState extends State<editPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  privateDB private_db = new privateDB();

  @override
  void initState() {
    super.initState();
    // Fetch the data for editing using widget.itemId and initialize the text controllers
    fetchData();
  }

  Future<void> fetchData() async {
    // Fetch the data based on widget.itemId and update the text controllers
    Map<String, dynamic> itemData = await private_db.getData(widget.itemId);
    nameController.text = itemData['name'];
    priceController.text = itemData['price'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "${nameController.text}"),
            ),
            SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: "${priceController.text}"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // edit item data
          String name = nameController.text;
          int price = int.parse(priceController.text);
          await private_db.updateData(widget.itemId, name, price);

          // Show a snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Record is updated"),
              duration: Duration(milliseconds: 3000),
            ),
          );

          // Navigate back to the previous screen
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}