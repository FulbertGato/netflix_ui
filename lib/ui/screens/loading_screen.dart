import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../repositories/data_repository.dart';
import 'tab_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }
  Future<void> initData ()async {
    final  dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.initData();

    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (context) => const TabScreen())
    
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/logo.ico"),
          const SpinKitRing(
            color: Colors.red,
            size: 25,
            duration: Duration(seconds: 20),
          ),
        ],
      ),
    );
  }
}
