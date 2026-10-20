import 'package:web/web.dart' as web;

Future<void> downloadCv(String url, String filename) async {
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = filename;
  web.document.body?.appendChild(anchor);
  anchor.click();
  anchor.remove();
}
