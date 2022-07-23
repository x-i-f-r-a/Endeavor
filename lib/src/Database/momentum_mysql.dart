import 'dart:async';

import 'package:mysql1/mysql1.dart';

class MomentumMySql{

  String? host;
  int? port;
  String? username;
  String? password;
  String? databaseName;
  MySqlConnection? _con;

  MomentumMySql({required this.host,required this.port,required this.username,required this.password,required this.databaseName}){
    
   connectDB();

  }

  void connectDB() async {
     var settings = new ConnectionSettings(
      host: host!, 
      port: port!,
      user: username!,
      password: password,
      db: databaseName
    );
    try{
      var conn = await MySqlConnection.connect(settings);
      print('[Connected to MySql server]');
      _con=conn;
    } on MySqlException catch(e){
      throw e;
    }
  }

  FutureOr InsertAll(String QUERY, List DATA) async {
    return await _con?.query(QUERY, DATA);
  }

  FutureOr FetchAll(String TABLE) async {
    final data = await _con?.query('SELECT * FROM $TABLE;');
    return data;
  }

  FutureOr FetchByCondition(String TABLE) async {
    final data = await _con?.query('SELECT * FROM $TABLE;');
    return data;
  }


  FutureOr Update(String QUERY, List DATA) async {
    await _con?.query(QUERY, DATA);
  }


}