import 'package:flutter/material.dart';
import '../Database/My_DB.dart';
import 'editCategory.dart';

class showCategories extends StatefulWidget {
  const showCategories({Key? key}) : super(key: key);

  @override
  State<showCategories> createState() => _showCategoriesState();
}

class _showCategoriesState extends State<showCategories> {
  privateDB private_db = privateDB();

  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Fetch updated data from the edit page
  Future<void> fetchData() async {
    List<Map<String, dynamic>> newData = await private_db.readData();
    setState(() {
      dataList = newData;
    });
  }

  // delete item from database and dataList
  Future<void> deleteItem(int index) async {
    int response = await private_db.deleteData(dataList[index]['id']);
    String res = "";
    if (response == 0) {
      res = "Error occurred while deleting the record";
    } else {
      res = "Record is deleted";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(res),
        duration: Duration(milliseconds: 3000),
      ),
    );
    setState(() {
      List<Map<String, dynamic>> modifiableList = List.from(dataList);
      modifiableList.removeAt(index);
      dataList = modifiableList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show Data"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, i) {
            return Card(
              child: ListTile(
                title: Text("${dataList[i]['name']}"),
                subtitle: Text("${dataList[i]['price']}"),
                trailing: IconButton(
                  onPressed: () async {
                    deleteItem(i);
                  },
                  icon: Icon(Icons.delete),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => editPage(dataList[i]['id']),
                    ),
                  ).then((_) {
                    fetchData();
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
