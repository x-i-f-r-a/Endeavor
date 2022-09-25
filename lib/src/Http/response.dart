import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:endeavor/endeavor.dart';


class Response {

  HttpResponse? res;
  Response(this.res);

  Future sendString(message) async {
    if(message != ''){
      res?.statusCode = HttpStatus.ok;
      res?.headers.contentType = ContentType.text;
      res!.write(message);
      await res!.close();
    }else{
      throw CustomException('[ Error ] Empty string supplied!').showError();
    }
  }

  Future sendJson(message) async {
    if(message!=''){
      res?.statusCode = HttpStatus.ok;
      res?.headers.contentType = ContentType.json;
      res?.write(jsonEncode(message));
      await res!.close();
    }else{
      throw CustomException('[ Error ] Empty json data supplied!').showError();
    }
  }

  Future redirect(String url, [int? statusCode]) async {
    
    try{
      res?.redirect(Uri(
        host: res?.connectionInfo?.remoteAddress.address,
        port: res?.connectionInfo?.localPort,
        path: url),);
    } catch(e){
      throw CustomException(e.toString()).showError();
    }

  
  }

  //to be edited
  FutureOr Template(String html, [Map? data=const{'':''}]) async {
    try{
      res?.statusCode = HttpStatus.ok;
      res?.headers.contentType =  ContentType.html;

        File file = File(Directory.current.path+'/templates/'+html);
        if(await file.exists()){
          if(data?.length!=0){
            var parsed;
            var content = await file.readAsString();
    
            data?.forEach((key, value) { 
              var replaced = content.replaceAll('#$key', value);
              parsed = replaced;
            });

            res?.write(parsed);
            await res?.close();
          }else{

            res?.addStream(file.openRead());
            await res?.close();
          }
        }else{
          await sendNotFound();
        }
    }on Exception{
      throw CustomException('Template engine error!').showError();
    }

  }


  Future renderHTML(String htmlFile) async {

    try{

      res?.statusCode = HttpStatus.ok;
      res?.headers.contentType =  ContentType.html;

      String filepath = Directory.current.path.toString()+'/templates/'+htmlFile;

      final File file = File(filepath);

      if(await file.exists()){
        try{
          res?.addStream(file.openRead());
          await res?.close();

        }catch(e){
          await sendInternalError();
        }
      }else{
        await sendNotFound();
      }

         
          
        
    }on FileSystemException catch (e){
      res?.write('File Not Found : $e');
      await res?.close();
    }


    
  }

  Future<void> sendInternalError() async {
    res?.statusCode = HttpStatus.internalServerError;
    res?.write('Internal Error');
    await res?.close();
  }

  Future<void> sendNotFound() async {
    res?.statusCode = HttpStatus.notFound;
    res?.headers.contentType = ContentType.html;
    res?.write('<br><center><h2>Not Found</h2></center>');
    await res?.close();
  }


  Future<void> sendCustomErrorFile(int code, htmlFile) async {
    res?.statusCode = code;
    res?.headers.contentType =  ContentType.html;

     
    String filepath = Directory.current.path.toString()+'/templates/'+htmlFile;

    final File file = File(filepath);

    if(await file.exists()){
      try{
        res?.addStream(file.openRead());
        res?.close();

      }catch(e){
        await sendInternalError();
      }
    }else{
      await sendNotFound();
    }
  }

  dynamic setHeaders(Map headersList){
    if(headersList.length!=0){
      headersList.forEach((key, value) { 
        res?.headers.set(key, ' $value');
      });
    }
  }

  dynamic setCors({String Methods='GET, POST, PUT, PATCH, DELETE', int MaxAge=36000, String Origins='*', }){
    res?.headers.set('Access-Control-Allow-Origin', Origins);
    res?.headers.set('Access-Control-Allow-Methods', Methods);
    res?.headers.set('Access-Control-Allow-Headers', '*');
    res?.headers.set('Access-Control-Max-Age', MaxAge);
  }


  FutureOr setCookies(String key ,var value, [DateTime? expireOn, bool? isSecure=true, bool httpOnly=true, int maxage = 15]) async {
    final cookie = Cookie(key, value.toString());
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day, now.hour, now.minute+15);
    cookie.httpOnly = httpOnly;
    cookie.secure = isSecure!;
    cookie.maxAge = maxage;
    cookie.expires = expireOn == '' ? date : expireOn;
    res?.cookies.add(cookie);

  } 

  FutureOr removeCookies(String key) async {
    res?.cookies.remove(key);
    
  }
  FutureOr clearCookies() async {
    res?.cookies.cast();

    
  }

  Future HTML(String htmlString) async {
    if(htmlString!=''){
      res?.statusCode = HttpStatus.ok;
      res?.headers.contentType =  ContentType.html;

      res?.write(htmlString);
      await res?.close();
    }else{
      throw CustomException('[ Error ] String is empty').showError();
    }
  }

  Future flashMessage(String reason, var message) async {
    
    if(reason.isNotEmpty && message!=''){
      final cookie = Cookie(reason, message.toString());
      DateTime now = new DateTime.now().toLocal();
      DateTime date = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second, now.microsecond+1000);
      cookie.httpOnly = false;
      cookie.expires = date;
      res?.cookies.add(cookie);
    }else{
      throw CustomException('[ Error ] Either one of two data is not supplied!').showError();
    }
  }
 

}
