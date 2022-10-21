import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:endeavor/endeavor.dart';
import 'package:mime/mime.dart';

class Request {

  HttpRequest? req;
  

  Request(this.req);

  dynamic storeSession(key, value){
    req?.session.remove(key);
    req?.session[key] = value;
  }


  dynamic getSession(key){
    if(req?.session[key] != ''){
      return req?.session[key];
    }
  }

  dynamic clearSession(key){
    if(req?.session[key] != ''){
      req?.session.remove(key);
    }
  }
  

  dynamic query() async {
    Map? queryParams = await req?.uri.queryParameters;
    return queryParams;

  }

  Future body() async {
    final bodyData = await req!.cast<List<int>>().transform(Utf8Decoder()).join();
    var queryParams = Uri(query: bodyData).queryParameters;
    return queryParams;
  }

  FutureOr DownloadFile() async {
    List<int> bytes = [];
    try{
       
      await for(var data in req!){
        bytes.addAll(data);
       
      }
      print('[ Receiving File ]');
      final boundary = req?.headers.contentType?.parameters['boundary'];


      final transformer = MimeMultipartTransformer(boundary!);
      final stream = Stream.fromIterable([bytes]);
     
      final parts = await transformer.bind(stream).toList();

      for(var part in parts){
        var content_deposition = part.headers['content-disposition'];
        
        var fileName = RegExp(r'filename="([^"]*)"')
                      .firstMatch(content_deposition!)
                      ?.group(1);
       print('[ File Received ] : '+fileName.toString());

        var content = await part.toList();

        await File(Directory.current.path+'/Files/'+fileName!).create(recursive: true).then((value) {
          value.writeAsBytes(content[0]);
        });

        

      }
    } on Exception{
      throw CustomException('File not saved!').showError();
    }

  }

  dynamic getPathData(int index){
    final segmentData = req?.uri.pathSegments;
    return segmentData?[index];

  }

  
}

