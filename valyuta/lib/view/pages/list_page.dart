import 'package:flutter/material.dart';
import '../../model/api_data.dart';
import '../widjets/item_list.dart';

class ListPage extends StatefulWidget {
  final List<ApiData> data;

  const ListPage(this.data, {Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 11, 12, 21),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 22, 24, 39),
        title: Text(
          "Umumiy ro'yxat",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ItemList(widget.data),
    );
  }
}
