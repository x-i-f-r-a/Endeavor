import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'Http/request.dart';
import 'Http/response.dart';

class Endeavor {

  Map? cors;
  Map? basicAuth;

  Endeavor({this.cors=const{}, this.basicAuth=const{},});

  List<Function> _get_functions = [];
  List<Function> _post_functions = [];
  List<Function> _put_functions = [];
  List<Function> _update_functions = [];
  List<Function> _delete_functions = [];
  List<Function> _patch_functions = [];


  List<String> _getpaths = [];
  List<String> _postpaths = [];
  List<String> _putpaths = [];
  List<String> _updatepaths = [];
  List<String> _deletepaths = [];
  List<String> _patchpaths = [];




  Map _getrouteKeys = new Map();
  Map _postrouteKeys = new Map();
  Map _putrouteKeys = new Map();
  Map _updaterouteKeys = new Map();
  Map _deleterouteKeys = new Map();
  Map _patchrouteKeys = new Map();
  Map _getmethod = new Map();
  Map _postmethod = new Map();
  Map _putmethod = new Map();
  Map _deletemethod = new Map();
  Map _updatemethod = new Map();
  Map _patchmethod = new Map();
  

  Future<HttpServer> createServer(int port, String host, {bool isShared = false}) async {
    
    return await HttpServer.bind(host, port, shared: isShared);

  }


  void createGETMap(){
    for(var i = 0; i < _getpaths.length; i++){
    
      _getrouteKeys[_getpaths[i]] = _get_functions[i];
    
    }
  }

  void createPOSTMap(){
    for(var i = 0; i < _postpaths.length; i++){
    
      _postrouteKeys[_postpaths[i]] = _post_functions[i];
    
    }
  }

  void createPUTMap(){
    for(var i = 0; i < _putpaths.length; i++){
    
      _putrouteKeys[_putpaths[i]] = _put_functions[i];
    
    }
  }

  void createUPDATEMap(){
    for(var i = 0; i < _updatepaths.length; i++){
    
      _updaterouteKeys[_updatepaths[i]] = _update_functions[i];
    
    }
  }

  void createDELETEMap(){
    for(var i = 0; i < _deletepaths.length; i++){
    
      _deleterouteKeys[_deletepaths[i]] = _delete_functions[i];
    
    }

  }

  void createPATCHMap(){
    for(var i = 0; i < _patchpaths.length; i++){
    
      _patchrouteKeys[_patchpaths[i]] = _patch_functions[i];
    
    }

  }



  void _handleGET(HttpRequest request, String route) async {

    try{
      DateTime today = new DateTime.now();
      if(
        _getmethod[request.uri.path.toString()].toString() == request.method.toString()
        
      ){
       
       
        print('[ ${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')} ${today.hour}:${today.minute}:${today.second.round()} ] ${ request.method.toString()} ${request.uri.path.toString()}');
         
        
        final Response res = Response(request.response);
        final Request req = Request(request);


         if(basicAuth?.length==0){
            _getrouteKeys[request.uri.path.toString()](req, res);
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
                  _getrouteKeys[request.uri.path.toString()](req, res);
                }else{
                  request.response.headers.set('WWW-Authenticate', 'Basic realm="Secure Area"');
                  request.response.statusCode = 401;
                  request.response.write('401 Unauthorized');
                  await request.response.close();
                }
              
              }
            }else{
              
              _getrouteKeys[request.uri.path.toString()](req, res);
              
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

  void _handlePOST(HttpRequest request, String route) async {

    try{
      DateTime today = new DateTime.now();
      if(
        _postmethod[request.uri.path.toString()].toString() == request.method.toString()
        
      ){
       
       
        print('[ ${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')} ${today.hour}:${today.minute}:${today.second.round()} ] ${ request.method.toString()} ${request.uri.path.toString()}');
         
        
        final Response res = Response(request.response);
        final Request req = Request(request);


         if(basicAuth?.length==0){
            _postrouteKeys[request.uri.path.toString()](req, res);
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
                  _postrouteKeys[request.uri.path.toString()](req, res);
                }else{
                  request.response.headers.set('WWW-Authenticate', 'Basic realm="Secure Area"');
                  request.response.statusCode = 401;
                  request.response.write('401 Unauthorized');
                  await request.response.close();
                }
              
              }
            }else{
              
              _postrouteKeys[request.uri.path.toString()](req, res);
              
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

  void _handleDELETE(HttpRequest request, String route) async {

    try{
      DateTime today = new DateTime.now();
      if(
        _deletemethod[request.uri.path.toString()].toString() == request.method.toString()
        
      ){
       
       
        print('[ ${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')} ${today.hour}:${today.minute}:${today.second.round()} ] ${ request.method.toString()} ${request.uri.path.toString()}');
         
        
        final Response res = Response(request.response);
        final Request req = Request(request);


         if(basicAuth?.length==0){
            _deleterouteKeys[request.uri.path.toString()](req, res);
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
                  _deleterouteKeys[request.uri.path.toString()](req, res);
                }else{
                  request.response.headers.set('WWW-Authenticate', 'Basic realm="Secure Area"');
                  request.response.statusCode = 401;
                  request.response.write('401 Unauthorized');
                  await request.response.close();
                }
              
              }
            }else{
              
              _deleterouteKeys[request.uri.path.toString()](req, res);
              
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

  void _handlePUT(HttpRequest request, String route) async {

    try{
      DateTime today = new DateTime.now();
      if(
        _putmethod[request.uri.path.toString()].toString() == request.method.toString()
        
      ){
       
       
        print('[ ${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')} ${today.hour}:${today.minute}:${today.second.round()} ] ${ request.method.toString()} ${request.uri.path.toString()}');
         
        
        final Response res = Response(request.response);
        final Request req = Request(request);


         if(basicAuth?.length==0){
            _putrouteKeys[request.uri.path.toString()](req, res);
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
                  _putrouteKeys[request.uri.path.toString()](req, res);
                }else{
                  request.response.headers.set('WWW-Authenticate', 'Basic realm="Secure Area"');
                  request.response.statusCode = 401;
                  request.response.write('401 Unauthorized');
                  await request.response.close();
                }
              
              }
            }else{
              
              _putrouteKeys[request.uri.path.toString()](req, res);
              
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

  void _handleUPDATE(HttpRequest request, String route) async {

    try{
      DateTime today = new DateTime.now();
      if(
        _updatemethod[request.uri.path.toString()].toString() == request.method.toString()
        
      ){
       
       
        print('[ ${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')} ${today.hour}:${today.minute}:${today.second.round()} ] ${ request.method.toString()} ${request.uri.path.toString()}');
         
        
        final Response res = Response(request.response);
        final Request req = Request(request);


         if(basicAuth?.length==0){
            _updaterouteKeys[request.uri.path.toString()](req, res);
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
                  _updaterouteKeys[request.uri.path.toString()](req, res);
                }else{
                  request.response.headers.set('WWW-Authenticate', 'Basic realm="Secure Area"');
                  request.response.statusCode = 401;
                  request.response.write('401 Unauthorized');
                  await request.response.close();
                }
              
              }
            }else{
              
              _updaterouteKeys[request.uri.path.toString()](req, res);
              
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

  void _handlePATCH(HttpRequest request, String route) async {

    try{
      DateTime today = new DateTime.now();
      if(
        _patchmethod[request.uri.path.toString()].toString() == request.method.toString()
        
      ){
       
       
        print('[ ${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')} ${today.hour}:${today.minute}:${today.second.round()} ] ${ request.method.toString()} ${request.uri.path.toString()}');
         
        
        final Response res = Response(request.response);
        final Request req = Request(request);


         if(basicAuth?.length==0){
            _patchrouteKeys[request.uri.path.toString()](req, res);
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
                  _patchrouteKeys[request.uri.path.toString()](req, res);
                }else{
                  request.response.headers.set('WWW-Authenticate', 'Basic realm="Secure Area"');
                  request.response.statusCode = 401;
                  request.response.write('401 Unauthorized');
                  await request.response.close();
                }
              
              }
            }else{
              
              _patchrouteKeys[request.uri.path.toString()](req, res);
              
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




  void _Handle(HttpRequest request){
  
    
    switch(request.method.toString()){


      case 'GET':
        _handleGET(request, request.uri.path.toString());
        break;

      case 'POST':
        _handlePOST(request, request.uri.path.toString());
        break;

      case 'PUT':
        _handlePUT(request, request.uri.path.toString());
        break;

      case 'UPDATE':
        _handleUPDATE(request, request.uri.path.toString());
        break;

      case 'DELETE':
        _handleDELETE(request, request.uri.path.toString());
        break;

      case 'PATCH':
        _handlePATCH(request, request.uri.path.toString());
        break;

      default:
        request.response.write('Unsupported HTTP Method');
        request.response.close();
        break;
        
    }
    

    
  }


  Future<void> _HandleHttpRequest(HttpServer server, bool compress) async {
    server.autoCompress = compress;
    server.serverHeader = 'Endeavor';

    await for(HttpRequest request in server)  {
      
      try{
        
        switch(request.method.toString()){

          case 'GET': {
            if( _getpaths.contains(request.uri.path.toString()) || request.uri.hasQuery){
         

              if(cors?.length!=0){
                cors?.forEach((key, value) { 
                  request.response.headers.set(key, value);
                });
                
                
                this.createGETMap();
                _Handle(request);
              }else{
                
                this.createGETMap();
                _Handle(request);
              }
    
            }else{
              _serveStatic(request);
            }
          }
            
          break;

          case 'POST': {
            if( _postpaths.contains(request.uri.path.toString()) || request.uri.hasQuery){
         

              if(cors?.length!=0){
                cors?.forEach((key, value) { 
                  request.response.headers.set(key, value);
                });
                
                
                this.createPOSTMap();
                _Handle(request);
              }else{
                
                this.createPOSTMap();
                _Handle(request);
              }
    
            }else{
              _serveStatic(request);
            }
          }
          break;
          case 'PUT': {
            if( _putpaths.contains(request.uri.path.toString()) || request.uri.hasQuery){
         

              if(cors?.length!=0){
                cors?.forEach((key, value) { 
                  request.response.headers.set(key, value);
                });
                
                
                this.createPUTMap();
                _Handle(request);
              }else{
                
                this.createPUTMap();
                _Handle(request);
              }
    
            }else{
              _serveStatic(request);
            }
          }
          break;
          case 'UPDATE': {
            if( _updatepaths.contains(request.uri.path.toString()) || request.uri.hasQuery){
         

              if(cors?.length!=0){
                cors?.forEach((key, value) { 
                  request.response.headers.set(key, value);
                });
                
                
                this.createUPDATEMap();
                _Handle(request);
              }else{
                
                this.createUPDATEMap();
                _Handle(request);
              }
    
            }else{
              _serveStatic(request);
            }
          }
          break;
          case 'DELETE': {
            if( _deletepaths.contains(request.uri.path.toString()) || request.uri.hasQuery){
         

              if(cors?.length!=0){
                cors?.forEach((key, value) { 
                  request.response.headers.set(key, value);
                });
                
                
                this.createDELETEMap();
                _Handle(request);
              }else{
                
                this.createDELETEMap();
                _Handle(request);
              }
    
            }else{
              _serveStatic(request);
            }
          }
          break;

        case 'PATCH': {
            if( _patchpaths.contains(request.uri.path.toString()) || request.uri.hasQuery){
         

              if(cors?.length!=0){
                cors?.forEach((key, value) { 
                  request.response.headers.set(key, value);
                });
                
                
                this.createPATCHMap();
                _Handle(request);
              }else{
                
                this.createPATCHMap();
                _Handle(request);
              }
    
            }else{
              _serveStatic(request);
            }
          }
          break;

          default:
            break;
          
        }
       

    } on HttpException catch(e) {
      throw e;
    }

      
    }
  }


  Future GET(String path, Function fn) async {
    _getpaths.add(path);
    _get_functions.add(fn);
    _getmethod[path] = 'GET';
    
  }

  Future POST(String path, Function fn) async {
    _postpaths.add(path);
    _post_functions.add(fn);
    _postmethod[path] = 'POST';
    
  }

  Future PUT(String path, Function fn) async {
    _putpaths.add(path);
    _put_functions.add(fn);
    _putmethod[path] = 'PUT';
    
  }

  Future PATCH(String path, Function fn) async {
    _patchpaths.add(path);
    _patch_functions.add(fn);
    _patchmethod[path] = 'PATCH';
    
  }

  Future UPDATE(String path, Function fn) async {
    _updatepaths.add(path);
    _update_functions.add(fn);
    _updatemethod[path] = 'UPDATE';
    
  }

  Future DELETE(String path, Function fn) async {
    _deletepaths.add(path);
    _delete_functions.add(fn);
    _deletemethod[path] = 'DELETE';
    
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


