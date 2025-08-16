
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<T?> openAppBottomSheet<T>(Widget page,
        {bool isDismissible = true, Color alignColor = Colors.black54,bool isWarning=false,bool isSuccess=false}) async =>
    await Get.bottomSheet(
        backgroundColor: Colors.white,
        Container(
          decoration:  BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16)),
              border: Border(top: BorderSide(color:isWarning?Colors.red:isSuccess?Color(0xFF01E17B): Color(0xFF00BDCD)))),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8), topLeft: Radius.circular(8)),
              child: SafeArea(
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration:  BoxDecoration(
                            color: isWarning?Colors.red:isSuccess?Color(0xFF01E17B): Color(0xFF00BDCD),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                      ),
                      page
                    ],
                  ),
                ),
              )),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16)),
        ),
        isDismissible: isDismissible,
        isScrollControlled: true);
