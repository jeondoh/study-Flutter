import 'package:flutter/material.dart';

import 'data/todo.dart';

class TodoWritePage extends StatefulWidget {
  TodoWritePage({Key? key, required this.todo}) : super(key: key);

  Todo todo;

  @override
  State<TodoWritePage> createState() => _TodoWritePageState();
}

class _TodoWritePageState extends State<TodoWritePage> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _memoEditingController = TextEditingController();
  final List<Color> colors = const [
    Color(0xFF80d34f),
    Color(0xFFa794fa),
    Color(0xFFfb91d1),
    Color(0xFFfb8a94),
    Color(0xFFfebd9a),
    Color(0xFF51e29d),
    Color(0xFFFFFFFF),
  ];
  int colorIndex = 0;
  int categoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              widget.todo.title = _nameEditingController.text;
              widget.todo.memo = _memoEditingController.text;

              Navigator.of(context).pop(widget.todo);
            },
            child: Row(
              children: const [
                Text("저장", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: const Text('제목', style: TextStyle(fontSize: 20)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(controller: _nameEditingController),
            ),
            InkWell(
              onTap: () {
                widget.todo.color = colors[colorIndex].value;
                colorIndex++;
                setState(() {
                  colorIndex = colorIndex % colors.length;
                });
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("색상", style: TextStyle(fontSize: 20)),
                    Container(
                      width: 20,
                      height: 20,
                      color: Color(widget.todo.color),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                List<String> category = ["공부", "운동", "게임"];
                widget.todo.category = category[categoryIndex];
                categoryIndex++;
                setState(() {
                  categoryIndex = categoryIndex % category.length;
                });
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("카테고리", style: TextStyle(fontSize: 20)),
                    Text(widget.todo.category),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: const Text("메모", style: TextStyle(fontSize: 20)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 16),
              child: TextField(
                controller: _memoEditingController,
                maxLines: 10,
                minLines: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
