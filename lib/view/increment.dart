import 'package:counter_app1/controller/counter.dart';
import 'package:counter_app1/view/decrement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncrementCounter extends StatefulWidget {
  const IncrementCounter({super.key});

  @override
  State<IncrementCounter> createState() => _IncrementCounterState();
}

class _IncrementCounterState extends State<IncrementCounter> {
  int count = 0;

  void openDecrementPage(BuildContext context) async {
    final _ = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DecrementCount(),
        ));
    getCount();
  }

  Future<void> getCount() async {
    Counter.getCount().then((value) {
      setState(() {
        count = value;
      });
    });
  }

  Future<void> incrementCount() async {
    await Counter.setCount(count + 1);
    getCount();
  }

  @override
  void initState() {
    getCount();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Increment Count"),
        toolbarHeight: 80,
        actions: [
          IconButton(
            onPressed: () => openDecrementPage(context),
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          return Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 50,
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => incrementCount(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
