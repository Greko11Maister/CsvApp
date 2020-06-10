import 'dart:io';

import 'package:csv/csv.dart';
import 'package:csvapp/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Exportar Csv'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductModel> _productModel = ProductModel().exampleData();

  _exportCsv() async {
    List headers = ['Nombre','Codigo','Cantidad','Fecha'];
    List<List<dynamic>> rows = List<List<dynamic>>();
    rows.add(headers);

    _productModel.forEach((element) {
      List<dynamic> row = List();

      row.add(element.name);
      row.add(element.code);
      row.add(element.cant);
      row.add(DateFormat("dd-MM-yyyy H:m a").format(element.createdAt));

      rows.add(row);
    });

    // Permissions
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    if(permission.value == 2){

      String dir = (await getExternalStorageDirectory()).absolute.path;
      DateTime time =  new DateTime.now();

      File file =  new File("$dir/products_${time.year}-${time.month}-${time.day}.csv");
      //convert to csv file
      String csv =  const ListToCsvConverter().convert(rows);

      file.writeAsString(csv).then(successFile,  onError: (err){

      });
    }

  }

  successFile(File file){
    OpenFile.open(file.path);
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: _productModel.length,
          shrinkWrap: true,
          itemBuilder: (_, i)=> ListTile(
            title: Text(_productModel[i].name),
            subtitle: Text(_productModel[i].code),
            trailing: Text("cant (${_productModel[i].cant})"),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _exportCsv();
        },
        backgroundColor: Colors.green,
        tooltip: 'Increment',
        child: Icon(Icons.file_download,),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
