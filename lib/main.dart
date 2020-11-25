import 'dart:async';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:splashscreen/splashscreen.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash2(),
    ));


//Splash Screen
class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: new HomePage(),
      title: new Text('TouchSafe',textScaleFactor: 4,),
      image: Image(image: AssetImage('assets/images/logo2.png')),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.green,
    );
  }
}

///////////////


//Webview Options4
class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);
  @override
  createState() => _WebViewContainerState(this.url);
}
class _WebViewContainerState extends State<WebViewContainer> {
  InAppWebViewController webView;
  var _url;
  //final _key = UniqueKey();
  _WebViewContainerState(this._url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Come Hungry, Leave Happy"),
        backgroundColor: Colors.green,
      ),

        body: Column(
          children: [
            Expanded(
                // child: WebView(
                //     key: _key,
                //     userAgent: "Mozilla/5.0 (Linux; Android 4.4.4; One Build/KTU84L.H4) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/33.0.0.0 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/28.0.0.20.16;]",
                //     javascriptMode: JavascriptMode.unrestricted,
                //     initialUrl: _url)
                child: InAppWebView(                  
                  initialUrl: _url,
                  // initialHeaders: {},
                  // initialOptions: InAppWebViewGroupOptions(
                  //   crossPlatform: InAppWebViewOptions(
                  //       debuggingEnabled: true,
                  //   )
                  // ),
                  // onWebViewCreated: (InAppWebViewController controller) {
                  //   webView = controller;
                  // },
                  // onLoadStart: (InAppWebViewController controller, String _url) {
                  //   setState(() {
                  //     this._url = _url;
                  //   });
                  // },
                  // onLoadStop: (InAppWebViewController controller, String _url) async {
                  //   setState(() {
                  //     this._url = _url;
                  //   });
                  // },
                  // onProgressChanged: (InAppWebViewController controller, int progress) {
                  //   setState(() {
                  //     //this.progress = progress / 100;
                  //   });
                  // },
                ),
              ),
          ],
        ));
  }
}
///////////////

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  
  String result = "Hungry? Scan to See Amazing Menu";

  Future _scanQR() async {

    try {
      String qrResult = await BarcodeScanner.scan();
      //setState(() {
        result = qrResult;
      //});
        Navigator.push(
    context,
    MaterialPageRoute(builder:(context) => WebViewContainer(result)
  ));

      //const url = 'https://flutter.dev';   For the URL action
      // if (await canLaunch(result)) {
      //   await launch(result);
      // } else {
      //   throw 'Could not launch $result';
      // }

    } 
    on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "I think you wanna miss some amazing food!!";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //backgroundColor: Colors.cyan[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome to TouchSafe Solutions"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Colors.green,
              Colors.green
            ])          
         ),        
     ),      
        //backgroundColor: Colors.pink,
      ),
      body: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey,
                    Colors.grey
                  ],
                )),
      
      child:Column(
        children: <Widget>[
          //Image.asset('/Users/GurmanBhullar/Desktop/TouchSafeInc_App/assets/icon.png'),   
          //Image.network('https://www.linkpicture.com/q/logo1_21.png'),
          Image(image: AssetImage('assets/images/logo1.png')),
          Container(

           child:Center(
             child:Container(
               
               padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
               width: (MediaQuery.of(context).size.width),
            height: 122,
            decoration: BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Colors.green,
              Colors.green
            ]),   
                  
              
              //color: Colors.red,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(),
            ),
            child: Text(
              result,
              style: new TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold,color: Colors.white),

            ),
            ),
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.greenAccent)
              )
          ),
          ),
          Image(image: AssetImage('assets/images/food.jpeg')),
        ],
      ),),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: Icon(Icons.camera_alt),
        label: Text("Scan Here",textScaleFactor: 1.5,),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }
}
