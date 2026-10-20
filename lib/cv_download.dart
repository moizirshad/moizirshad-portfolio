import 'cv_download_stub.dart'
    if (dart.library.js_interop) 'cv_download_web.dart' as implementation;

Future<void> downloadCv(String url, String filename) =>
    implementation.downloadCv(url, filename);
