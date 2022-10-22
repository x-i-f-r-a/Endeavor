```dart
// example.dart 

import 'dart:io';

import 'package:endeavor/endeavor.dart';

void main() async {

              
  final app = Endeavor();


  app.GET('/', (Request req, Response res){
    res.sendString('Ta daa');
  });

  app.GET('/home', RootController().home);

  
  await app.runServer();

}



class RootController{


  home(Request req, Response res) async {

    res.sendString('T daa');
    
  }
}

```

