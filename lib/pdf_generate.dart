/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

const PdfColor green = PdfColor.fromInt(0xff9ce5d0);
const PdfColor blue = PdfColor.fromInt(0xff1F82DE);
const PdfColor blueDark = PdfColor.fromInt(0xff3598F3);
const PdfColor grey = PdfColor.fromInt(0xff5E6470);
const PdfColor black = PdfColor.fromInt(0xff1A1C21);
const PdfColor blueOpacity = PdfColor.fromInt(0xffeff7fd);
const PdfColor dividerColor = PdfColor.fromInt(0xffe0e0e0);
const PdfColor whiteAccent = PdfColor.fromInt(0xFFFFF8E6);
const PdfColor greenAccent = PdfColor.fromInt(0xFF94D073);
const PdfColor greenAc = PdfColor.fromInt(0xFF7ED321);
const PdfColor greyReview = PdfColor.fromInt(0xFFebf1f5);
const PdfColor progressReview = PdfColor.fromInt(0xFF696D6E);
const PdfColor blackAppBarText = PdfColor.fromInt(0xFF27364E);
const PdfColor progress = PdfColor.fromInt(0xFF727677);
const PdfColor verticalDivider = PdfColor.fromInt(0xFFE4EAF0);
const PdfColor black1 = PdfColor.fromInt(0xFF4C4B52);
const PdfColor mainOrange = PdfColor.fromInt(0xFFFEC445);
const sep = 120.0;

void openFile({String? codeItem,num?day,num?price,num?rabat,num?subtotal,num?moms,num?total}) async {
  final permissionStatus = await Permission.storage.status;

  if(permissionStatus != PermissionStatus.granted){
    final status = await Permission.storage.request();
    if(status != PermissionStatus.granted){
      return null;
    }
  }
  final pdfFile = await generateCheck(PdfPageFormat.a4,codeItem: codeItem,day: day,price: price,rabat: rabat,subtotal: subtotal,moms: moms,total: total);
  Directory? dir;
  if (Platform.isAndroid) {
    dir = Directory('/storage/emulated/0/Download');
  } else {
    dir = await getApplicationDocumentsDirectory();
  }
  File file = File('${dir.path}/${pdfFile.buffer.hashCode}.pdf');
  await file.writeAsBytes(pdfFile, flush: true);
 await OpenFilex.open(file.path);

}

void shareFile({dynamic data}) async {
  final pdfFile = await generateReview(PdfPageFormat.a4, data1: data);
  Directory? dir;
  if (Platform.isAndroid) {
    dir = Directory('/storage/emulated/0/Download');
  } else {
    dir = await getApplicationDocumentsDirectory();
  }
  final file = File('${dir.path}/${pdfFile.buffer.hashCode}.pdf');
  file.writeAsBytesSync(pdfFile);
  Share.shareXFiles([XFile(file.path)], text: pdfFile.buffer.hashCode.toString());
}

Future<Uint8List> generateCheck(PdfPageFormat format, {String? codeItem,num?day,num?price,num?rabat,num?subtotal,num?moms,num?total}) async {
  final doc = pw.Document(title: 'My Résumé', author: 'David PHAM-VAN');

  final image1 = pw.MemoryImage(
    (await rootBundle.load('assets/png/icon.png')).buffer.asUint8List(),
  );

  // final pageTheme = await _myPageTheme(format);

  doc.addPage(
    pw.MultiPage(
      build: (pw.Context context) => [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: <pw.Widget>[
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
              pw.Column(children: [
                pw.Image(image1, height: 48, width: 48),
                pw.SizedBox(height: 8),
                pw.Text("Onic design", style: pw.Theme.of(context).defaultTextStyle.copyWith(fontWeight: pw.FontWeight.bold, color: blue, fontSize: 12)),
                pw.SizedBox(height: 32),
                pw.Text("Kvitto", style: pw.Theme.of(context).defaultTextStyle.copyWith(fontWeight: pw.FontWeight.bold, color: grey, fontSize: 30)),
                pw.SizedBox(height: 4),
                pw.Text("Adam Niklasson", style: pw.Theme.of(context).defaultTextStyle.copyWith(fontWeight: pw.FontWeight.bold, color: black, fontSize: 10)),
                pw.Text("+46 70 432 243", style: pw.Theme.of(context).defaultTextStyle.copyWith(fontWeight: pw.FontWeight.bold, color: grey, fontSize: 10)),
              ]),
              pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text("Onic design", style: const pw.TextStyle(color: grey, fontSize: 10)),
                pw.Text("Östra Hamngatan 16, 411 09 Göteborg", style: const pw.TextStyle(color: grey, fontSize: 10)),
                pw.Text("Org nr: 650612-2743", style: const pw.TextStyle(color: grey, fontSize: 10)),
              ])
            ]),
            pw.SizedBox(height: 48),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Expanded(
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Container(
                    height: 52,
                    alignment: pw.Alignment.centerLeft,
                    width: double.infinity,
                    padding: const pw.EdgeInsets.only(top: 10, left: 16, bottom: 10, right: 16),
                    decoration: const pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.only(topLeft: pw.Radius.circular(12), topRight: pw.Radius.circular(12), bottomLeft: pw.Radius.circular(12)), color: blueOpacity),
                    child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                      pw.Text("Invoice date", style: const pw.TextStyle(color: grey, fontSize: 10)),
                      pw.Text("15 Aug, 2023", style: pw.TextStyle(color: black, fontSize: 10, fontWeight: pw.FontWeight.bold))
                    ])),
                pw.Container(
                    alignment: pw.Alignment.centerLeft,
                    height: 52,
                    padding: const pw.EdgeInsets.only(left: 16, top: 10, bottom: 10),
                    child: pw.Text("Item description", style: pw.TextStyle(color: grey, fontSize: 10, fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(
                  height: 2,
                  child: pw.Divider(height: 0.5, thickness: 0.5, color: dividerColor),
                ),
                pw.Container(
                    height: 52,
                    alignment: pw.Alignment.centerLeft,
                    padding: const pw.EdgeInsets.only(left: 16, top: 10, bottom: 10),
                    child: pw.Text("$day dagars paket allt ingår", style: pw.TextStyle(color: black, fontSize: 10, fontWeight: pw.FontWeight.bold))),
                pw.Divider(height: 0.5, thickness: 0.5, color: dividerColor),
                pw.Container(
                  height: 52,
                  alignment: pw.Alignment.centerLeft,
                  padding: const pw.EdgeInsets.only(left: 16, top: 10, bottom: 10),
                ),
                pw.Divider(height: 0.5, thickness: 0.5, color: dividerColor),
              ])),
              pw.Expanded(
                  child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Container(
                    height: 52,
                    alignment: pw.Alignment.center,
                    padding: const pw.EdgeInsets.only(top: 10, left: 16, bottom: 10, right: 16),
                    child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                        pw.Text("Beställnings nr", style: const pw.TextStyle(color: grey, fontSize: 10)),
                        pw.Text("#$codeItem", style: pw.TextStyle(color: black, fontSize: 10, fontWeight: pw.FontWeight.bold))
                      ]),
                      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
                        pw.Text("Reference", style: const pw.TextStyle(color: grey, fontSize: 10)),
                        pw.Text("Adam Niklasson", style: pw.TextStyle(color: black, fontSize: 10, fontWeight: pw.FontWeight.bold))
                      ]),
                    ])),
                pw.Container(
                    height: 280,
                    width: double.infinity,
                    padding: const pw.EdgeInsets.only(top: 10, bottom: 10, right: 16),
                    decoration: const pw.BoxDecoration(borderRadius: pw.BorderRadius.only(topRight: pw.Radius.circular(12)), color: blueOpacity),
                    child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.only(left: 16),
                        height: 42.5,
                        alignment: pw.Alignment.centerLeft,
                        // color: PdfColors.red,
                        child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                          pw.Text("Qty", style: const pw.TextStyle(fontSize: 10, color: grey)),
                          pw.Text("Rate", style: const pw.TextStyle(fontSize: 10, color: grey)),
                          pw.Text("Amount", style: const pw.TextStyle(fontSize: 10, color: grey)),
                        ]),
                      ),
                      pw.Divider(height: 0.5, thickness: 0.5, color: dividerColor),
                      pw.Container(
                        padding: const pw.EdgeInsets.only(left: 16),
                        height: 53,
                        alignment: pw.Alignment.centerLeft,
                        // color: PdfColors.red,
                        child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                          pw.Text("1", style: const pw.TextStyle(fontSize: 10, color: grey)),
                          pw.Text("199", style: const pw.TextStyle(fontSize: 10, color: grey)),
                          pw.Text("199", style: const pw.TextStyle(fontSize: 10, color: grey)),
                        ]),
                      ),
                      pw.Divider(height: 0.5, thickness: 0.5, color: dividerColor),
                      pw.Container(
                        padding: const pw.EdgeInsets.only(left: 16),
                        height: 52,
                        alignment: pw.Alignment.centerLeft,
                      ),
                      pw.Divider(height: 0.5, thickness: 0.5, color: dividerColor),
                      pw.Container(
                          padding: const pw.EdgeInsets.only(left: 16, top: 10, bottom: 10),
                          // height: 52,
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Column(children: [
                            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                              pw.Text("Subtotal"),
                              pw.Text("$subtotal"),
                            ]),
                            pw.SizedBox(height: 10),
                            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                              pw.Text("Moms (25%)"),
                              pw.Text("$moms"),
                            ]),
                          ])),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 16, right: 16),
                        child: pw.Divider(height: 0.5, thickness: 0.5, color: dividerColor),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Container(
                          height: 40,
                          padding: const pw.EdgeInsets.only(left: 16, right: 0),
                          child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                            pw.Text("Rabatt"),
                            pw.Text("-$rabat"),
                          ])),
                    ])),
                pw.Container(
                  height: 40,
                  decoration: const pw.BoxDecoration(borderRadius: pw.BorderRadius.only(bottomRight: pw.Radius.circular(12), bottomLeft: pw.Radius.circular(12)), color: blueDark),
                  child: pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 16, right: 16),
                      child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                        pw.Text("Total", style: pw.TextStyle(color: PdfColors.white, fontSize: 12, fontWeight: pw.FontWeight.bold)),
                        pw.Text("$total SEK", style: pw.TextStyle(color: PdfColors.white, fontSize: 12, fontWeight: pw.FontWeight.bold)),
                      ])),
                )
              ]))
            ]),
            pw.SizedBox(height: 100),
            pw.Divider(height: 0.5, thickness: 0.5, color: dividerColor),
            pw.SizedBox(height: 28),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
              pw.Text("Thank you for the business!", style: const pw.TextStyle(color: black, fontSize: 10)),
              pw.RichText(
                text: const pw.TextSpan(
                    text: "+467 607 3113",
                    style: pw.TextStyle(fontSize: 10, color: black),
                    children: [pw.TextSpan(text: "   |   ", style: pw.TextStyle(color: grey, fontSize: 10)), pw.TextSpan(text: "hello@onic.design", style: pw.TextStyle(color: black, fontSize: 10))]),
              )
            ])
          ],
        ),
      ],
    ),
  );
  return doc.save();
}

Future<Uint8List> generateReview(PdfPageFormat format, {Map? data1}) async {
  final doc = pw.Document(title: 'My Résumé', author: 'David PHAM-VAN');
  double? presentTest = 0;
  int trueAnswers = 0;
  int falseAnswers = 0;
  double value = 0;
  int questions = 0;
  String? timeTest;
  List data = [];
  List dataCount = [];
  List<int> correctLength = [];
  List<int> wrongLength = [];
  final image0 = pw.MemoryImage(
    (await rootBundle.load('assets/png/spida.png')).buffer.asUint8List(),
  );
  final image1 = pw.MemoryImage(
    (await rootBundle.load('assets/png/spida.png')).buffer.asUint8List(),
  );
  final image2 = pw.MemoryImage(
    (await rootBundle.load('assets/png/apple_store.png')).buffer.asUint8List(),
  );
  final image3 = pw.MemoryImage(
    (await rootBundle.load('assets/png/play_market.png')).buffer.asUint8List(),
  );
  final bgShape = await rootBundle.loadString('assets/svg/Arrow1.svg');
  final bgShapeStar = await rootBundle.loadString('assets/svg/star-struck.svg');
  final bgShapeDowncast = await rootBundle.loadString('assets/svg/downcast.svg');
  trueAnswers = data1?["trueAnswers"];
  questions = data1?["questions"];
  timeTest = data1?["timeTest"];
  falseAnswers = data1?["falseAnswers"];
  presentTest = data1?["trueAnswers"] / data1?["questions"] * 100;

  value = presentTest! / 100 * .792 - .272;
  (data1?["data"] as Map).forEach((key, value) {
    if ((value['wrong'] as List).length + (value['correct'] as List).length != 0) {
      data.add(value);
      correctLength.add((value["correct"] as List).length);
      wrongLength.add((value["wrong"] as List).length);
    }
  });
  doc.addPage(
    pw.MultiPage(
      build: (pw.Context context) => [
        pw.Container(
          decoration: const pw.BoxDecoration(
            color: whiteAccent,
          ),
          child: pw.Column(
            children: [
              // pw.SizedBox(height: 30),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.SizedBox(height: 20),
                  presentTest! <= 50
                      ? pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                          pw.Text(
                            "Underkänd",
                            style: pw.TextStyle(color: PdfColors.red, fontSize: 32, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SvgImage(svg: bgShapeDowncast, height: 34, width: 36)
                        ])
                      : pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                          pw.Text(
                            "Godkänd",
                            style: pw.TextStyle(color: greenAccent, fontSize: 32, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SvgImage(svg: bgShapeStar, height: 34, width: 36)
                        ]),
                  pw.SizedBox(
                      height: 215,
                      width: 215,
                      child: pw.Stack(
                        alignment: pw.Alignment.center,
                        children: [
                          pw.Image(
                            image1,
                          ),
                          pw.Positioned(
                              left: 0,
                              bottom: 0,
                              right: 0,
                              top: 0,
                              child: pw.Transform.rotate(
                                angle: value,
                                child: pw.Container(margin: const pw.EdgeInsets.all(20), alignment: pw.Alignment.topLeft, child: pw.SvgImage(svg: bgShape, height: 90, width: 90)
                                    // color: Colors.transparent,
                                    // child: SvgPicture.asset(
                                    //   "assets/svg/Arrow1.svg",
                                    //   height: 90,
                                    //   width: 90,
                                    // ),
                                    ),
                              )),
                          pw.Positioned(
                              left: 0,
                              right: 0,
                              bottom: 15,
                              child: pw.Text(
                                "Passing score $presentTest%",
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(
                                  fontSize: 12,
                                  color: progressReview,
                                ),
                                maxLines: 2,
                              ))
                        ],
                      )),
                  // const SizedBox(height: 16),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      if (timeTest != null)
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              timeTest,
                              style: pw.TextStyle(
                                color: blackAppBarText,
                                fontSize: 28,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              "Your time",
                              style: pw.TextStyle(
                                color: progress,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      if (timeTest != null)
                        pw.Container(
                          height: 50,
                          width: 2,
                          margin: const pw.EdgeInsets.only(top: 10, right: 17, left: 17),
                          alignment: pw.Alignment.center,
                          color: verticalDivider,
                        ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            '${presentTest.toInt()}%',
                            style: pw.TextStyle(
                              color: mainOrange,
                              fontSize: 28,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            "Your score",
                            style: const pw.TextStyle(
                              color: progress,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      pw.Container(
                        height: 50,
                        width: 2,
                        margin: const pw.EdgeInsets.only(top: 10, right: 17, left: 17),
                        alignment: pw.Alignment.center,
                        color: verticalDivider,
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            '$trueAnswers/$questions st',
                            style: pw.TextStyle(
                              color: blackAppBarText,
                              fontSize: 28,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            "Right answer",
                            style: pw.TextStyle(
                              color: progress,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              pw.Container(
                  height: 25,
                  margin: const pw.EdgeInsets.only(left: 25, right: 25),
                  padding: const pw.EdgeInsets.only(left: 16, right: 16),
                  decoration: const pw.BoxDecoration(borderRadius: pw.BorderRadius.only(topRight: pw.Radius.circular(15), topLeft: pw.Radius.circular(15)), color: PdfColors.white)),
              for (int i = 0; i < data.length; i++)
                pw.Container(
                    height: 40,
                    margin: const pw.EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    padding: const pw.EdgeInsets.only(left: 16, right: 16),
                    decoration: const pw.BoxDecoration(color: PdfColors.white),
                    child: pw.Column(children: [
                      // pw.SizedBox(height: 16),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(
                            flex: 4,
                            child: pw.Text(
                              data[i]["name"],
                              style: const pw.TextStyle(
                                fontSize: 15,
                                color: progressReview,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          pw.Text(
                            style: const pw.TextStyle(
                              fontSize: 10,
                              color: progressReview,
                            ),
                            maxLines: 1,
                            "${(data[i]["correct"] as List).length}/${(data[i]["correct"] as List).length + (data[i]["wrong"] as List).length}",
                          )
                        ],
                      ),
                      pw.SizedBox(height: 2),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          for (int j = 0; j < (10); j++)
                            pw.Container(
                              height: 4,
                              width: 35,
                              decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(2),
                                  color: j <
                                          (((correctLength[i].toDouble() / (wrongLength[i] + correctLength[i]).toDouble()) * 10 > 0 &&
                                                  (correctLength[i].toDouble() / (wrongLength[i] + correctLength[i]).toDouble()) * 10 < 1)
                                              ? 1
                                              : ((correctLength[i].toDouble() / (wrongLength[i] + correctLength[i]).toDouble()) * 10).toInt())
                                      ? greenAc
                                      : greyReview),
                            ),
                        ],
                      ),
                    ])),
              pw.Container(
                  height: 25,
                  margin: const pw.EdgeInsets.only(left: 25, right: 25),
                  padding: const pw.EdgeInsets.only(left: 16, right: 16),
                  decoration: const pw.BoxDecoration(borderRadius: pw.BorderRadius.only(bottomRight: pw.Radius.circular(15), bottomLeft: pw.Radius.circular(15)), color: PdfColors.white)),
              pw.SizedBox(height: 25),
              pw.Center(child: pw.Text("Sätt igång med din körkortsresa!", style: const pw.TextStyle(color: black1))),
              pw.SizedBox(height: 15),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                pw.UrlLink(
                  destination: "https://play.google.com/store/apps/details?id=com.whatsapp&hl=ru&gl=US",
                  child: pw.Image(image2, height: 40, width: 119),
                ),
                pw.UrlLink(
                  destination: "https://play.google.coms/store/apps/details?id=com.whatsapp&hl=ru&gl=US",
                  child: pw.Image(image3, height: 40, width: 119),
                ),
              ]),
              pw.SizedBox(height: 35),
            ],
          ),
        ),
      ],
    ),
  );
  return doc.save();
}
