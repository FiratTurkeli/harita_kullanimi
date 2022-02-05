import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//AIzaSyBKHdPVyzcnezlhIFdSUzf8yKR0lO8n-U8

 Completer<GoogleMapController> haritaKontrol = Completer();

 var baslangicKonum = CameraPosition(target: LatLng(38.7775368,26), zoom: 4);

 List<Marker> isaretler = <Marker>[];


 Future<void> konumaGit() async {
   GoogleMapController controller = await haritaKontrol.future;
   var gidilecekIsaret = Marker(
       markerId: MarkerId("Id"),
     position: LatLng(41.7775368,28.4517426),
     infoWindow: InfoWindow(title: "İstanbul", snippet: "Ev")

   );
   setState(() {
     isaretler.add(gidilecekIsaret);

   });

   var gidilecekKonum = CameraPosition(target: LatLng(41.7775368,28.4517426), zoom: 8);
   controller.animateCamera(CameraUpdate.newCameraPosition(gidilecekKonum));
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          children: <Widget>[
            
            SizedBox(
              width: 400,
              height: 300,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: baslangicKonum,
                markers: Set<Marker>.of(isaretler),
                onMapCreated: (GoogleMapController controller){
                  haritaKontrol.complete(controller);
                },
              ),
            ),
            ElevatedButton(onPressed: (){
              konumaGit();

            },
                child: Text("Konuma git"))


          ],
        ),
      ),

    );
  }
}
