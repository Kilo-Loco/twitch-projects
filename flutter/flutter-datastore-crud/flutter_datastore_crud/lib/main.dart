import 'package:flutter/material.dart';
import 'amplifyconfiguration.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'models/ModelProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _amplify = Amplify();

  final objectId = '123';

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() {
    final provider = ModelProvider();
    final dataStorePlugin = AmplifyDataStore(modelProvider: provider);

    _amplify.addPlugin(dataStorePlugins: [dataStorePlugin]);

    _amplify.configure(amplifyconfig);

    print('Amplify configured');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amplify CRUD',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CREATE
          FlatButton(
              onPressed: () => create(),
              child: Text('Create'),
              color: Colors.green,
              textColor: Colors.white),

          // READ ALL
          FlatButton(
              onPressed: () => readAll(),
              child: Text('Read ALL'),
              color: Colors.blue,
              textColor: Colors.white),

          // READ BY ID
          FlatButton(
              onPressed: () => readById(),
              child: Text('Read BY ID'),
              color: Colors.cyan,
              textColor: Colors.white),

          // UPDATE
          FlatButton(
              onPressed: () => update(),
              child: Text('Update'),
              color: Colors.orange,
              textColor: Colors.white),

          // DELETE
          FlatButton(
              onPressed: () => delete(),
              child: Text('Delete'),
              color: Colors.red,
              textColor: Colors.white),
        ],
      ),
    );
  }

  void create() async {
    final myObject = MyObject(id: objectId, value: 'This is a sexy object!');

    try {
      await Amplify.DataStore.save(myObject);

      print('Saved ${myObject.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void readAll() async {
    try {
      List<MyObject> myObjects =
          await Amplify.DataStore.query(MyObject.classType);

      print(myObjects.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<MyObject> readById() async {
    try {
      List<MyObject> myObjects = await Amplify.DataStore.query(
          MyObject.classType,
          where: MyObject.ID.eq(objectId));
      if (myObjects.isEmpty) {
        print('No objects found with id: $objectId');
        return null;
      }
      final myObject = myObjects.first;

      print(myObject.toString());
      return myObject;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void update() async {
    try {
      var myObject = await readById();

      final updatedObject =
          myObject.copyWith(value: myObject.value + ' [UPDATED]');

      await Amplify.DataStore.save(updatedObject);

      print('Saved updated object as ${updatedObject.toString()}');
    } catch (e) {
      print(e);
    }
  }

  void delete() async {
    try {
      final myObject = await readById();

      await Amplify.DataStore.delete(myObject);

      print('Deleted object with id: ${myObject.id}');
    } catch (e) {
      print(e);
    }
  }
}
