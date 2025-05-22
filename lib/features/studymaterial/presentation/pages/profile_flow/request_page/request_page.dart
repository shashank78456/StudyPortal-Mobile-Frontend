import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studyportal/core/theme/constants.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/request_file_type/request_file_type.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
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
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Request",
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
                    hintText:
                        ' Eg: DEP-101 (Introduction to Departmental course)',
                    hintStyle: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(StudyPortalConstants.spGrey)),
                    labelStyle: const TextStyle(),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(const Radius.circular(8.0).r),
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
                          BorderRadius.all(const Radius.circular(4.0).r),
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
                  height: 50.0.h,
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
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    title: const Text('File Request Complete'),
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
                                            'Our team will try to get the requested file ASAP'),
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
                      backgroundColor: _courseCodeController.text.isNotEmpty &&
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
    );
  }
}
