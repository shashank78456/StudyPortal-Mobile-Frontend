import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/request_file_type/request_file_type.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _formKey = GlobalKey<FormState>();
  final _courseCodeController = TextEditingController();
  final _fileDescriptionController = TextEditingController();

  @override
  void dispose() {
    _courseCodeController.dispose();
    _fileDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Upload",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.sp),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Upload File',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    height: 100.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement file picker functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'lib/core/svgs/upload_file.svg',
                            height: 48.0,
                            width: 48.0,
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Select file from your system',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(StudyPortalConstants.spRoyalBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '*Supported formats: PDF, Word, PNG, JPEG, EPUB',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(StudyPortalConstants.spGrey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Course Code',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _courseCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Course Code',
                      hintText:
                          ' Eg: DEP-101 (Introduction to Departmental course)',
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color(StudyPortalConstants.spGrey)),
                      labelStyle:
                          TextStyle(color: Color(StudyPortalConstants.spGrey)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a course code';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select File Type',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const RequestedFileTabs(),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'File Description',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _fileDescriptionController,
                    decoration: const InputDecoration(
                      labelText: 'File Description',
                      hintText: ' Eg: Previous year quiz papers...',
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color(StudyPortalConstants.spGrey)),
                      labelStyle:
                          TextStyle(color: Color(StudyPortalConstants.spGrey)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a file description';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: _courseCodeController.text.isNotEmpty &&
                              _fileDescriptionController.text.isNotEmpty
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                // Process the input data
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      title: const Text('File Upload Complete'),
                                      content: const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                            size: 48.0,
                                          ),
                                          SizedBox(height: 16.0),
                                          Text(
                                              'Our team will review the file before uploading it to the portal'),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Check Status'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _courseCodeController
                                    .text.isNotEmpty &&
                                _fileDescriptionController.text.isNotEmpty
                            ? const Color(StudyPortalConstants.spRoyalBlue)
                            : const Color(StudyPortalConstants.spStrokeGrey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
