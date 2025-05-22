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
            padding: const EdgeInsets.all(16.0).r,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     'Upload File',
                  //     style: TextStyle(
                  //       fontSize: 16.sp,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 16.0.h),
                  SizedBox(
                    width: double.infinity,
                    height: 120.h,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement file picker functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(8).r,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0).r,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'lib/core/svgs/upload_file.svg',
                            height: 48.0.h,
                            width: 48.0.w,
                          ),
                          SizedBox(height: 8.0.h),
                          Text(
                            'Select file from your system',
                            style: TextStyle(
                              fontSize: 16.0.sp,
                              color:
                                  const Color(StudyPortalConstants.spRoyalBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
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
                  SizedBox(height: 20.0.h),
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
                  SizedBox(height: 8.0.h),
                  TextFormField(
                    controller: _courseCodeController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(),
                      hintText:
                          ' Eg: DEP-101 (Introduction to Departmental course)',
                      hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(StudyPortalConstants.spGrey)),
                      // labelStyle:
                      //     TextStyle(color: Color(StudyPortalConstants.spGrey)),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)).r,
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
                  SizedBox(height: 16.0.h),
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
                  SizedBox(height: 16.0.h),
                  const RequestedFileTabs(),
                  SizedBox(height: 16.0.h),
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
                  SizedBox(height: 16.0.h),
                  TextFormField(
                    controller: _fileDescriptionController,
                    decoration: InputDecoration(
                      hintText: ' Eg: Previous year quiz papers...',
                      hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(StudyPortalConstants.spGrey)),
                      labelStyle: const TextStyle(),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)).r,
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
                  SizedBox(height: 16.0.h),
                  SizedBox(
                    width: double.infinity,
                    height: 60.h,
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
                                            BorderRadius.circular(8.0).r,
                                      ),
                                      title: const Text('File Upload Complete'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                            size: 48.0,
                                          ),
                                          SizedBox(height: 16.0.h),
                                          const Text(
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
                          borderRadius: BorderRadius.circular(4.0).r,
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 20.sp),
                      ),
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
