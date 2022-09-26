import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:endeavor/Endeavor.dart';
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
    return bodyData;
  }

  FutureOr DownloadFile() async {
    List<int> bytes = [];
    try{
      await for(var data in req!){
        bytes.addAll(data);
      }
      final boundary = req?.headers.contentType?.parameters['boundary'];

      final transformer = MimeMultipartTransformer(boundary!);
      final stream = Stream.fromIterable([bytes]);

      final parts = await transformer.bind(stream).toList();

      for(var part in parts){
        var content_deposition = part.headers['content-deposition'];
        var fileName = RegExp(r'filename="([^"]*)"')
                      .firstMatch(content_deposition!)
                      ?.group(1);

        var content = await part.toList();

        await File(Directory.current.path+'/img/'+fileName!).writeAsBytes(content[0]);

        

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

