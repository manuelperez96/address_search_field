import 'package:flutter/material.dart';
import 'package:address_search_text_field/address_search_text_field.dart';
import 'package:toast/toast.dart'; // External library

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageOne(),
    );
  }
}

class PageOne extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  TextEditingController controller = TextEditingController();
  String text = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: size.width * 0.80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AddressSearchTextField(
                controller: controller,
                country: "Ecuador",
                city: "Esmeraldas",
                hintText: "Dirección",
                noResultsText: "No hay resultados...",
                exceptions: [
                  "Esmeraldas, Ecuador",
                  "Esmeraldas Province, Ecuador",
                  "Ecuador"
                ],
                onDone: (AddressPoint point) async {
                  AddressPoint point2;
                  if (point.latitude != null)
                    point2 = await AddressPoint.fromPoint(
                      latitude: point.latitude,
                      longitude: point.longitude,
                    );
                  setState(() {
                    text = "${point.toString()}\n\n${point2.toString()}";
                  });
                  Navigator.of(context).pop();
                },
                onCleaned: () => print("limpio"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: Text(text),
              ),
              FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PageTwo())),
                child: Text("Page Two"),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddressSearchBox(
        country: "Ecuador",
        city: "Esmeraldas",
        hintText: "Dirección",
        noResultsText: "No hay resultados...",
        exceptions: [
          "Esmeraldas, Ecuador",
          "Esmeraldas Province, Ecuador",
          "Ecuador"
        ],
        onDone: (AddressPoint point) async {
          // I use toast dependency to prettier show the result
          Toast.show(
            point.toString(),
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
          );
        },
      ),
    );
  }
}
