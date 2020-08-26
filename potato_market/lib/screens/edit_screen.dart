import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/edit';
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  void _saveProduct() async {
    if (_titleController.text.isEmpty || _priceController.text.isEmpty) {
      return;
    }
    await FirebaseFirestore.instance.collection('test').add({
      'title': _titleController.text,
      'price': _priceController.text,
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글쓰기'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: '제목'),
                  controller: _titleController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(labelText: '가격'),
                  controller: _priceController,
                ),
              ],
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('완료'),
            onPressed: _saveProduct,
          )
        ],
      ),
    );
  }
}
