
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'Http/request.dart';
import 'Http/response.dart';

class Momentum {

  Map? cors;
  Map? basicAuth;

  Momentum({this.cors=const{}, this.basicAuth=const{},});

  List<Function> functions = [];
  List<String> paths = [];


  Map routeKeys = new Map();
  Map methods = new Map();
  

  Future<HttpServer> createServer(int port, String host, {bool isShared = false}) async {
    
    return await HttpServer.bind(host, port, shared: isShared);

  }


  void createMap(){
    for(var i = 0; i < paths.length; i++){
    
      routeKeys[paths[i]] = functions[i];
    
    }
  }


  void _Handle(HttpRequest request){
    
    try{
      DateTime today = new DateTime.now();
      if(methods[request.uri.path.toString()].toString() == request.method.toString()){
       
       
        print('[ ${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')} ${today.hour}:${today.minute}:${today.second.round()} ] ${methods[request.uri.path.toString()].toString()} ${request.uri.path.toString()}');
         
        
        final Response res = Response(request.response);
        final Request req = Request(request);


         if(basicAuth?.length==0){
            routeKeys[request.uri.path.toString()](req, res);
         }else{
          
           basicAuth?.forEach((key, value) async { 
            if(key.toString() == request.uri.path.toString()){
              final authHead = request.headers.value(HttpHeaders.authorizationHeader);
              if(authHead == null || authHead == ''){
                request.response.headers.set('WWW-Authenticate', 'Basic realm="Secure Area"');
                request.response.statusCode = 401;
                request.response.write('401 Unauthorized');
                await request.response.close();
              }else
              {
                final data = utf8.decode(base64.decode(authHead.replaceAll('Basic ', ''))).toString();

                if(data.toString()==value.toString()){
                  routeKeys[request.uri.path.toString()](req, res);
                }else{
                  request.response.headers.set('WWW-Authenticate', 'Basic realm="Secure Area"');
                  request.response.statusCode = 401;
                  request.response.write('401 Unauthorized');
                  await request.response.close();
                }
              
              }
            }else{
              
              routeKeys[request.uri.path.toString()](req, res);
              
            }
          });
         }
        
      }else{
        request.response.statusCode = HttpStatus.methodNotAllowed;
        request.response.write('Unsupported HTTP Method');
        request.response.close();
      }
      
      

    }catch(e){
      CustomException('[ Error ] ${e.toString()}').showError();
      
    }
  }


  Future<void> _HandleHttpRequest(HttpServer server, bool compress) async {
    server.autoCompress = compress;
    server.serverHeader = 'Momentum-V0.0.1';

    await for(HttpRequest request in server)  {
      
      
      try{
        
        if( paths.contains(request.uri.path.toString()) || request.uri.hasQuery){
         

          if(cors?.length!=0){
            cors?.forEach((key, value) { 
              request.response.headers.set(key, value);
            });
            
            
            this.createMap();
            _Handle(request);
          }else{
            
            this.createMap();
            _Handle(request);
          }
    
        }else{
          _serveStatic(request);
        }
       

    } on HttpException catch(e) {
      throw e;
    }

      
    }
  }


  Future GET(String path, Function fn) async {
    paths.add(path);
    functions.add(fn);
    methods[path] = 'GET';
    
  }

  Future POST(String path, Function fn) async {
    paths.add(path);
    functions.add(fn);
    methods[path] = 'POST';
    
  }

  Future PUT(String path, Function fn) async {
    paths.add(path);
    functions.add(fn);
    methods[path] = 'PUT';
    
  }

  Future PATCH(String path, Function fn) async {
    paths.add(path);
    functions.add(fn);
    methods[path] = 'PATCH';
    
  }

  Future UPDATE(String path, Function fn) async {
    paths.add(path);
    functions.add(fn);
    methods[path] = 'UPDATE';
    
  }

  Future DELETE(String path, Function fn) async {
    paths.add(path);
    functions.add(fn);
    methods[path] = 'DELETE';
    
  }

  Future _serveStatic(HttpRequest req) async {
    String _rootPath = Directory.current.path;
      File staticFile = File(_rootPath+'/templates/'+req.uri.path);
      await staticFile.exists().then((bool found) async {
        if (found) {
          req.response.statusCode = HttpStatus.ok;
          var mimeType = lookupMimeType(_rootPath+'/templates/'+req.uri.path);
          req.response.headers.set('Content-Type', mimeType!);
          staticFile.openRead().pipe(req.response).catchError((e) { 
            throw CustomException(e.toString()).showError();
          });
        } else {
          req.response.statusCode = HttpStatus.notFound;
          req.response.headers.contentType = ContentType.html;
          req.response.write('<br><center><h2>Not Found</h2></center>');
          await req.response.close();
        }
      });
  }
  
   Future<void> runServer( {final server='', String? host='127.0.0.1', int port=80, bool compress = true, bool isShared = false}) async {

    
    
    if(server is HttpServer){
      
      print('[ INFO ] SERVER STARTED');
      
      _HandleHttpRequest(server, compress);
      
    
    }else{
      if(host==''){
        final address = InternetAddress.loopbackIPv4;
        final createserver = await createServer(port, address.toString(), isShared: isShared );
        print('[ INFO ] SERVER STARTED AT ${address.toString()}:$port/');
        
        _HandleHttpRequest(createserver, compress);
        
      }else{
        final createserver = await createServer(port, host.toString(), isShared: isShared );
        print('[ INFO ] SERVER STARTED AT http://$host:$port/');
        
        _HandleHttpRequest(createserver, compress);

      }
    }
    
    
  }




}





class CustomException implements Exception {
  String? reason;
  CustomException(this.reason);

  showError(){
   return reason!;
  }
}


