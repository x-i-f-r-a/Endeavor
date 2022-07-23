import 'dart:async';
import 'dart:io';

import 'package:sqlite3/sqlite3.dart';



class MomentumSqlite {

  String? dbName;
  Database? _db;

  MomentumSqlite({required this.dbName}){
    print('Using sqlite3 ${sqlite3.version}');
    final DB = sqlite3.open(File(Directory.current.path+'/db/sqlite3/$dbName.db').create(recursive: true).toString());
    print('[ Connection to sqlite3 database $dbName.db ]');
    _db = DB;
  }
  

  FutureOr exec(String query) async {
    if(query!=''){
      final q = _db?.execute(query);
      return q;
    }else{
      throw CustomSqlException('Empty data supplied').showError();
    }
  }

  FutureOr query(String query, {String? val}) async {
    if(query!=''){
      final ResultSet? r = _db?.select(query);
      return r;
    }else{
      throw CustomSqlException('Empty data supplied');
    }
  }
  FutureOr getAll(String tableName) async {
    if(query!=''){
      final ResultSet? r = _db?.select('SELECT * FROM $tableName');
      return r;
    }else{
      throw CustomSqlException('Empty data supplied');
    }
  }
  
  FutureOr addQuery(String query, List values) async {
    try{
      final stmt = _db?.prepare('$query');
      stmt
        ?..execute(values);
    }on Exception catch(e){
      print(e);
    }
      
  }

  FutureOr disposeDB() async {
    return _db?.dispose();
  }



  

  

}


class CustomSqlException implements Exception {
  String? reason;
  CustomSqlException(this.reason);

  Future<void> showError()async{
     print(reason);
  }
}