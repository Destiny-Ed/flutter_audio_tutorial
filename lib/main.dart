import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

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
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = '';

  ///Audio player
  AudioPlayer? audioPlayer;
  late AudioCache audioCache;

  @override
  void initState() {
    super.initState();

    setState(() {
      audioPlayer = AudioPlayer();
      audioCache = AudioCache(fixedPlayer: audioPlayer);
    });
  }

  void playAudio() {
    audioPlayer!.stop();

    audioCache.play('music.mp3');
  }

  void stopAudio() {
    audioPlayer!.stop();
  }

  @override
  void dispose() {
    audioPlayer!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    audioPlayer!.getCurrentPosition().then((value) {
      setState(() {
        _counter = value.toString();
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: playAudio,
            tooltip: 'Play',
            child: const Icon(Icons.play_arrow),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: stopAudio,
            tooltip: 'Stop',
            child: const Icon(Icons.stop),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
