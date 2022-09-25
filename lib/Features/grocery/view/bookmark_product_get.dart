import 'package:flutter/material.dart';

class BookmarkProductGetScreen extends StatefulWidget {
  const BookmarkProductGetScreen(
      {Key? key, required this.id, required this.name})
      : super(key: key);
  final int id;
  final String name;

  @override
  State<BookmarkProductGetScreen> createState() =>
      _BookmarkProductGetScreenState();
}

class _BookmarkProductGetScreenState extends State<BookmarkProductGetScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}'),
      ),
      body: Center(
        child: Text(widget.id.toString()),
      ),
    ));
  }
}
