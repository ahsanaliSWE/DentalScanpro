import 'package:dentalscanpro/view/models/mobilenet.dart';
import 'package:dentalscanpro/view/models/resnet.dart';
import 'package:dentalscanpro/view/models/yolo_scan.dart';
import 'package:dentalscanpro/view/models/yolocam.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  
  @override
  State<ScanScreen> createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           ElevatedButton(
              onPressed: (){
                 Get.to(const YoloVision());
               }, 
            child: const Text("Yolo Vision")),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){
                Get.to(const YoloCam());
               }, 
            child: const Text("Ultralytics Yolo")),    
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){
                Get.to(const MobileNet());
               }, 
            child: const Text("MobileNet")),    
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: (){
                Get.to(const ResNet());
               }, 
            child: const Text("ResNet")),     
          ],
        ),
      )
    );
  }
}