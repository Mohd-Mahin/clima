import 'dart:convert';

import 'package:clima/screens/location-screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const appKey = 'c8a2d4b1568d67565bc39eca3443db80';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    geoLocation();
  }

  void geoLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$appKey&units=metric');
    Response resp = await get(url);
    var decodeData = jsonDecode(resp.body);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData: decodeData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.white, size: 100),
      ),
    );
  }
}
