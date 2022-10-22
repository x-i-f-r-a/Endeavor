```dart
// example.dart 

import 'package:endeavor/endeavor.dart';

void main() async {

              
  final app = Endeavor();


  // Html response

  app.GET('/', (Request req, Response res){
    res.HTML(

      '''
       <!doctype html>
        <html>
        <body>
          <form action="/download" method="post" enctype="multipart/form-data">
            <input type="file" name="file" /><br />
            
            <button type="submir">Save</button>
          </form>
        </body>
        </html>
      
      
      '''



    );
  });

  // Get POST data

  app.POST('/', (Request req, Response res) async {
    
    print(await req.body()); 

  });

  // Download a html form upload file
  app.POST('/download', (Request req, Response res) async {

    req.DownloadFile();

  });


  await app.runServer();

}



class RootController{


  home(Request req, Response res) async {

    res.sendString('T daa');
    
  }
}




```

