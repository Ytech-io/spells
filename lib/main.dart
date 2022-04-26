import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:spells/data/spell.dart';
import 'package:spells/layout/spell_card.dart';

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
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you  ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.teal),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // txtController.addListener(() {
  //     List<Spell> result = __search(txtController.text, spells);
  //     setState(() {
  //       items = result;
  //     });
  //   });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController txtController = TextEditingController();
  List<Spell> items = spells;

  final fuse = Fuzzy<Spell>(spells,
      options: FuzzyOptions(keys: [
        WeightedKey(name: 'name', getter: (item) => item.name, weight: 1),
        WeightedKey(
            name: 'description', getter: (item) => item.description, weight: 1),
        WeightedKey(name: 'type', getter: (item) => item.type, weight: 1)
      ]));

  @override
  void initState() {
    super.initState();

    txtController.addListener(() {
      List<Spell> result = __search(txtController.text);

      print(result);
      print(txtController.text);

      setState(() {
        items = result;
      });
    });
  }

  List<Spell> __search(term) {
    return fuse.search(term).map((item) => item.item).toList();
  }

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            TextField(
                controller: txtController,
                decoration: const InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search))),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) =>
                  SpellCard(spell: items[index]),
            ))
          ]),
        ));
  }
}
