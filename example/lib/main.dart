import 'package:material/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: Example(),
    );
  }
}


class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          ListTile(
            title: Text("data"),
          ),
          FlatButton(
            child: Text("Flat"),
            onPressed: () {},
          ),
          FlatButton.icon(
            icon: Icon(Icons.file_download),
            label: Text("Flat Icon"),
            onPressed: () {},
          ),
          RaisedButton(
            child: Text("Flat"),
            onPressed: () {},
          ),
          RaisedButton.icon(
            icon: Icon(Icons.file_download),
            label: Text("Flat Icon"),
            onPressed: () {},
          ),
          MaterialButton(
            child: Text("Flat Icon"),
            onPressed: () {},
          ),
          RawMaterialButton(
            child: Text("Flat Icon"),
            onPressed: () {},
          ),
          RawButton(
            trailing: Icon(Icons.filter),
            // color: Colors.white,
            child: Text("Aqui"),
            onPressed: () {},
          ),
          Button(
            leading: Icon(Icons.filter),
            trailing: Icon(Icons.add),
            color: Colors.black,
            loading: true,
            child: Text("Aqui"),
            onPressed: () {},
          ),
          OutlineButton(
            leading: Icon(Icons.filter),
            trailing: Icon(Icons.add),
            child: Text("Outline"),
            onPressed: () {},
          ),
          AsyncButton(
            leading: Icon(Icons.filter),
            trailing: Icon(Icons.add),
            child: Text("Outline"),
            builder: (context) {
              return Future.delayed(Duration(seconds: 2), () {
                return "Ok";
              });
            },
            onSuccess: print,
            onError: print, 
            // type: AsyncButtonType.outline,
          ),
        ],
      ),
    );
  }
}


 
