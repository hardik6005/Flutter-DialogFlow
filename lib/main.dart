import 'package:flutter/material.dart';
import 'package:flutter_dialogflow_sample/chat_flow.dart';
import 'package:flutter_dialogflow_v2/flutter_dialogflow_v2.dart' as dFlow;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late dFlow.AuthGoogle authGoogle;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatbotDialogflow(title: "My Bot")));
         // agentResponse();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void agentResponse() async {
    //_textController.clear();

    dFlow.DetectIntentRequest request = dFlow.DetectIntentRequest(
        queryInput: dFlow.QueryInput(
            text: dFlow.TextInput(
      text: "Hello",
      languageCode: dFlow.Language.english,
    )), queryParams: dFlow.QueryParameters(
      resetContexts: true,
    ),);

    dFlow.AuthGoogle authGoogle =
        await dFlow.AuthGoogle(fileJson: "assets/dialogflow_flutter.json")
            .build();

    dFlow.Dialogflow dialogFlow = dFlow.Dialogflow(
      authGoogle: authGoogle, sessionId: '123456'
    );
    dFlow.DetectIntentResponse response =
        await dialogFlow.detectIntent(request);
    print("RESPONSE : " + response.toJson().toString());
    // Facts message = Facts(
    //   text: response.getMessage() ??
    //       CardDialogflow(response.getListMessage()[0]).title,
    //   name: "Flutter",
    //   type: false,
    // );
    // setState(() {
    //   messageList.insert(0, message);
    // });
  }

  void init() async {
    authGoogle =
        await dFlow.AuthGoogle(fileJson: "assets/dialogflow_flutter.json")
            .build();
  }
}
