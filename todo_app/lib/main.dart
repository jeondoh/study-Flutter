import 'package:flutter/material.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/data/utils.dart';
import 'package:todo_app/write.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<Todo> todos = [
    Todo(
      title: "패캠 강의 듣기",
      memo: "앱 개발 입문",
      category: "공부",
      color: Colors.redAccent.value,
      date: 20220823,
    ),
    Todo(
      title: "헬스",
      memo: "팔굽혀펴기",
      category: "운동",
      color: Colors.blueAccent.value,
      done: 1,
      date: 20220828,
    ),
  ];

  void getTodayTodo() {}

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Todo todo = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoWritePage(
                todo: Todo(
                  date: Utils.getFormatTime(DateTime.now()),
                ),
              ),
            ),
          );
          setState(() {
            widget.todos.add(todo);
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: const Text(
                "오늘하루",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (index == 1) {
            List<Todo> undone = widget.todos.where((t) => t.done == 0).toList();

            return Column(
              children: List.generate(
                undone.length,
                (index) {
                  Todo t = undone[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        t.done = t.done == 0 ? t.done = 1 : t.done = 0;
                      });
                    },
                    onLongPress: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TodoWritePage(todo: t),
                        ),
                      );
                      setState(() {});
                    },
                    child: _TodoCardWidget(t: t),
                  );
                },
              ),
            );
          } else if (index == 2) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: const Text(
                "완료된 하루",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (index == 3) {
            List<Todo> done = widget.todos.where((t) => t.done == 1).toList();

            return Column(
              children: List.generate(
                done.length,
                (index) {
                  Todo t = done[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        t.done = t.done == 0 ? t.done = 1 : t.done = 0;
                      });
                    },
                    onLongPress: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TodoWritePage(todo: t),
                        ),
                      );
                      setState(() {});
                    },
                    child: _TodoCardWidget(t: t),
                  );
                },
              ),
            );
          }
          return const Text("");
        },
        itemCount: 4,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: "오늘",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: "기록",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: "더보기",
          ),
        ],
      ),
    );
  }
}

class _TodoCardWidget extends StatelessWidget {
  const _TodoCardWidget({Key? key, required this.t}) : super(key: key);

  final Todo t;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(t.color),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                t.done == 0 ? "미완료" : "완료",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            t.memo,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
