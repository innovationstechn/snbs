import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:snbs/api/data_uploader.dart';
import 'package:snbs/models/configuration.dart';
import 'package:snbs/models/upload_item.dart';
import 'package:snbs/pages/dnn_scan_page.dart';
import 'package:snbs/state/configuration_state.dart';

void main() async {
  await _initHive();
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNBS',
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
      home: DNNScanPage(),
    );
  }
}

Future<void> _initHive() async {
  Hive.registerAdapter(UploadItemAdapter());
  Hive.registerAdapter(ConfigurationAdapter());

  await Hive.initFlutter();
  await DataUploader.initialize();
  await ConfigurationState.initialize();
}

//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   List<String> scanned = [];
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: StreamBuilder<String>(
//           stream: _helper.scanStream,
//           builder: (context, snapshot) {
//             scanned.add(snapshot.data ?? "?");
//
//             return ListView.builder(
//               itemCount: scanned.length,
//               itemBuilder: (context, index) {
//                 return BarcodeListElement(
//                   index: index,
//                   barcode: scanned[index],
//                 );
//               },
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: scanBarcode,
//         tooltip: 'Scan',
//         child: const Icon(Icons.qr_code_scanner),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
