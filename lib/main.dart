import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

int a = 0;
var output = "";
var output1 = "";

var output2 = "";

var output3 = "";

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 20,
        onPressed: () {
          return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Add Item'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          onChanged: (value) {
                            output1 = value;
                          },
                          decoration:
                              InputDecoration(hintText: 'name of product'),
                        ),
                        TextField(
                          onChanged: (value) {
                            output2 = value;
                          },
                          decoration: InputDecoration(hintText: 'rate'),
                        ),
                        TextField(
                          onChanged: (value) {
                            output3 = value;
                          },
                          decoration: InputDecoration(hintText: 'Discount'),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            Navigator.pop(context);
                            list.add(card(
                              name: output1,
                              rate: output2,
                              discount: output3,
                            ));
                            a++;
                          },
                        );
                      },
                      child: Text('Add'),
                    ),
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.orange,
        ),
      ),
      appBar: AppBar(
        elevation: 20,
        shadowColor: Colors.pink[200],
        backgroundColor: Colors.grey[600],
        title: Text('TODO App'),
        centerTitle: true,
      ),
      body: list.isEmpty
          ? Center(
              child: Container(
              height: 100,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Product',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    'If you want to Add Product So Click on the bellow Button',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ))
          : GridView.builder(
              itemCount: list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  mainAxisExtent: 250),
              itemBuilder: (BuildContext contex, int index) {
                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Delete the product'),
                                            content: Text(
                                                'Click on the Delete Button to Delete the Product from the list'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      Navigator.pop(context);
                                                      list.removeAt(index);
                                                    });
                                                  },
                                                  child: Text('Delete')),
                                            ],
                                          );
                                        });
                                  },
                                  child: Text('Delete'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Eddit Item'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  TextField(
                                                    onChanged: (value) {
                                                      output1 = value;
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'name of product'),
                                                  ),
                                                  TextField(
                                                    onChanged: (value) {
                                                      output2 = value;
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: 'rate'),
                                                  ),
                                                  TextField(
                                                    onChanged: (value) {
                                                      output3 = value;
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText: 'Discount'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      Navigator.pop(context);
                                                      list.replaceRange(
                                                        index,
                                                        index + 1,
                                                        {
                                                          card(
                                                            name: output1,
                                                            rate: output2,
                                                            discount: output3,
                                                          ),
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text('Edit'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Text('Edit'),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: list[index],
                );
              },
            ),
    );
  }
}

List list = [];

class card extends StatefulWidget {
  card({this.name, this.rate, this.discount});
  final String name;
  final String rate;
  final String discount;

  @override
  _cardState createState() => _cardState();
}

class _cardState extends State<card> {
  File _image;

  final imagePick = ImagePicker();

  Future getimage() async {
    final image = await imagePick.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(
        image.path,
      );
    });
  }

  int a = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _image == null
              ? IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: getimage,
                )
              : SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Image.file(
                      _image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
          SizedBox(
            height: 20,
          ),
          Text('Name : ${widget.name}'),
          SizedBox(
            height: 10,
          ),
          Text('Price : ${widget.rate}'),
          SizedBox(
            height: 10,
          ),
          Text('Discount : ${widget.discount}'),
        ],
      ),
    );
  }
}
