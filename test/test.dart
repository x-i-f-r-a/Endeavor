import 'package:endeavor/Endeavor.dart';
void main() async {

              
  final app = Endeavor();


  app.GET('/', (Request req, Response res){
    res.sendString('Ta daa');
  });

  app.POST('/', (Request req, Response res) async {
    
    print(await req.body()); 

  });

  await app.runServer();

}



class RootController{


  home(Request req, Response res) async {

    res.sendString('T daa');
    
  }
}


