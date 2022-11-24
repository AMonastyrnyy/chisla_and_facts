import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  final focus = FocusNode();
  String fact = '';

  void buttonFact() {
    focus.unfocus();
    if (controller.text == '') {
      setState(() {
        fact = 'Надо ввести число';
      });
    } else {
      http.get(Uri.http('numbersapi.com', '${controller.text}/trivia')).then((value) {
        setState(() {
          fact = value.body;
        });
      });
    }
  }

  void buttonClean() {
    controller.clear();
    focus.requestFocus();
    setState(() {
      fact = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Факты о числах'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  focusNode: focus,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onEditingComplete: buttonFact,
                  decoration: InputDecoration(
                    hintText: 'Введите число',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: buttonFact, child: const Text('Поиск')),
                    const SizedBox(
                      width: 100,
                    ),
                    ElevatedButton(onPressed: buttonClean, child: const Text('Очистить')),
                  ],
                ),
                const SizedBox(height: 15),
                Text(fact),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
