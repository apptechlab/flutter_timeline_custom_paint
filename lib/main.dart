import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({
    super.key,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  ui.Image? heatImage;
  ui.Image? inseminationImage;
  ui.Image? pdImage;
  ui.Image? dryperiodImage;
  ui.Image? calvingImage;

  @override
  void initState() {
    getImages();
    super.initState();
  }

  ///
  /// load these images in a prior screen or
  /// use state management to reload the screen after
  /// the assets are loaded.
  ///
  Future<void> getImages() async {
    heatImage = await loadUiImage("assets/heat.png");
    inseminationImage = await loadUiImage("assets/insemination.png");
    pdImage = await loadUiImage("assets/pd.png");
    dryperiodImage = await loadUiImage("assets/dryperiod.png");
    calvingImage = await loadUiImage("assets/calving.png");
  }

  Future<ui.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: CustomPaint(
          painter: CustomPainterCanvas(
            heatImage: heatImage,
            inseminationImage: inseminationImage,
            pdImage: pdImage,
            dryPeriodImage: dryperiodImage,
            calvingImage: calvingImage,
          ),
          size: Size(size.width, 200),
        ),
      ),
    ));
  }
}

class CustomPainterCanvas extends CustomPainter {
  CustomPainterCanvas({
    required this.heatImage,
    required this.calvingImage,
    required this.dryPeriodImage,
    required this.inseminationImage,
    required this.pdImage,
  }) : super();

  final ui.Image? heatImage;
  final ui.Image? inseminationImage;
  final ui.Image? pdImage;
  final ui.Image? dryPeriodImage;
  final ui.Image? calvingImage;

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..strokeWidth = 2
      ..color = Colors.grey;
    Paint circlePaint = Paint()..color = Colors.white;
    Paint circlePaintBorder = Paint()
      ..strokeWidth = 2
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;
    Paint imagePaint = Paint();
    ui.ParagraphStyle paragraphStyle = ui.ParagraphStyle(
        fontSize: 14, fontWeight: FontWeight.w400, textAlign: TextAlign.center);
    ui.TextStyle textStyle = ui.TextStyle(color: Colors.black87);

    ///
    /// heat text
    ///
    ui.ParagraphBuilder heatTextBuilder = ui.ParagraphBuilder(paragraphStyle);
    heatTextBuilder.pushStyle(textStyle);
    heatTextBuilder.addText("Heat");
    ui.Paragraph heatText = heatTextBuilder.build();
    heatText.layout(ui.ParagraphConstraints(width: size.width));

    ///
    /// insemination text
    ///
    ui.ParagraphBuilder inseminationTextBuilder =
        ui.ParagraphBuilder(paragraphStyle);
    inseminationTextBuilder.pushStyle(textStyle);
    inseminationTextBuilder.addText("Insemination");
    ui.Paragraph inseminationText = inseminationTextBuilder.build();
    inseminationText.layout(ui.ParagraphConstraints(width: size.width));

    ///
    /// insemination text
    ///
    ui.ParagraphBuilder pdBuilder = ui.ParagraphBuilder(paragraphStyle);
    pdBuilder.pushStyle(textStyle);
    pdBuilder.addText("Pregnancy\nDetection");
    ui.Paragraph pdText = pdBuilder.build();
    pdText.layout(ui.ParagraphConstraints(width: size.width));

    ///
    /// insemination text
    ///
    ui.ParagraphBuilder dryPeriodBuilder = ui.ParagraphBuilder(paragraphStyle);
    dryPeriodBuilder.pushStyle(textStyle);
    dryPeriodBuilder.addText("Dry\nPeriod");
    ui.Paragraph dryPeriodText = dryPeriodBuilder.build();
    dryPeriodText.layout(ui.ParagraphConstraints(width: size.width));

    ///
    /// insemination text
    ///
    ui.ParagraphBuilder calvingTextBuilder =
        ui.ParagraphBuilder(paragraphStyle);
    calvingTextBuilder.pushStyle(textStyle);
    calvingTextBuilder.addText("Calving");
    ui.Paragraph calvingText = calvingTextBuilder.build();
    calvingText.layout(ui.ParagraphConstraints(width: size.width));

    ///
    /// background vertical line
    ///
    canvas.drawLine(Offset(size.width, size.height / 2),
        Offset(0, size.height / 2), linePaint);

    ///
    /// calving image with background white
    /// with grey border and text
    ///
    canvas.drawCircle(Offset(size.width / 1.06, size.height / 2),
        size.height / 8, circlePaint);
    canvas.drawCircle(Offset(size.width / 1.06, size.height / 2),
        size.height / 8, circlePaintBorder);
    if (calvingImage != null) {
      canvas.drawImage(calvingImage!,
          Offset(size.width / 1.09, size.height / 2.2), imagePaint);
    }
    canvas.drawParagraph(
        calvingText, Offset(size.width / 2.26, size.height / 1.4));
    canvas.drawLine(Offset(size.width / 1.06, size.height / 1.4),
        Offset(size.width / 1.06, size.height / 1.6), linePaint);

    ///
    /// dry period image with background white
    /// with grey border and text
    ///
    canvas.drawCircle(Offset(size.width / 1.4, size.height / 2),
        size.height / 8, circlePaint);
    canvas.drawCircle(Offset(size.width / 1.4, size.height / 2),
        size.height / 8, circlePaintBorder);
    if (dryPeriodImage != null) {
      canvas.drawImage(dryPeriodImage!,
          Offset(size.width / 1.47, size.height / 2.3), imagePaint);
    }
    canvas.drawParagraph(
        dryPeriodText, Offset(size.width / 4.7, size.height / 8.8));
    canvas.drawLine(Offset(size.width / 1.4, size.height / 2.6),
        Offset(size.width / 1.4, size.height / 3.6), linePaint);

    ///
    /// pd image with background white
    /// with grey border and text
    ///
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.height / 8, circlePaint);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.height / 8,
        circlePaintBorder);
    if (pdImage != null) {
      canvas.drawImage(
          pdImage!, Offset(size.width / 2.15, size.height / 2.3), imagePaint);
    }
    canvas.drawParagraph(pdText, Offset(0, size.height / 1.4));
    canvas.drawLine(Offset(size.width / 2, size.height / 1.4),
        Offset(size.width / 2, size.height / 1.6), linePaint);

    ///
    /// insemination image with background white
    /// with grey border and text
    ///
    canvas.drawCircle(Offset(size.width / 3.5, size.height / 2),
        size.height / 8, circlePaint);
    canvas.drawCircle(Offset(size.width / 3.5, size.height / 2),
        size.height / 8, circlePaintBorder);
    if (inseminationImage != null) {
      canvas.drawImage(inseminationImage!,
          Offset(size.width / 4, size.height / 2.3), imagePaint);
    }
    canvas.drawParagraph(
        inseminationText, Offset(-size.width / 4.6, size.height / 5.2));
    canvas.drawLine(Offset(size.width / 3.5, size.height / 2.6),
        Offset(size.width / 3.5, size.height / 3.6), linePaint);

    ///
    /// heat image with background white
    /// with grey border and text
    ///
    canvas.drawCircle(
        Offset(size.width / 16, size.height / 2), size.height / 8, circlePaint);
    canvas.drawCircle(Offset(size.width / 16, size.height / 2), size.height / 8,
        circlePaintBorder);
    if (heatImage != null) {
      canvas.drawImage(
          heatImage!, Offset(size.width / 38, size.height / 2.3), imagePaint);
    }
    canvas.drawParagraph(
        heatText, Offset(-size.width / 2.28, size.height / 1.4));
    canvas.drawLine(Offset(size.width / 16, size.height / 1.4),
        Offset(size.width / 16, size.height / 1.6), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
