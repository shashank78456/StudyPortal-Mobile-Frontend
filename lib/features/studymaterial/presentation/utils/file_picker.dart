import 'package:file_picker/file_picker.dart';

Future<(String?, bool)> filePicker() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    PlatformFile file = result.files.first;
    if (file.extension != "pdf") {
      return ("Unsupported FileType", false);
    }
    return (file.path, true);
  } else {
    return ("Invalid Path", false);
  }
}
