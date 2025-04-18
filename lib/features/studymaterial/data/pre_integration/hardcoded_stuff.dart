import 'package:flutter/material.dart';
import 'package:studyportal/features/studymaterial/domain/entities/file.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/file_tiles/file_tile.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/file_type_enum.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/activity_card/activity_card.dart';
import 'package:studyportal/features/studymaterial/presentation/widgets/tools/activity_status_enum.dart';

class HardCodedConstants {
  static const List<Color> courseCardColors = [
    Color(0xFF0D891B),
    Color(0xFFCF4141),
    Color(0xFF20284C)
  ];

  static List<FileTile> fileTiles = [
    FileTile(
      file: File(
        id: 0,
        courseCode: "ABC-101",
        type: "link",
        name: "Introduction to Electrical Circuits",
        s3Url: "https://abc.com/intro-electrical-circuits",
        status: "approved",
        description: "Mr. Landu Chamar ki file",
      ),
    ),
    FileTile(
      file: File(
        id: 1,
        courseCode: "ABC-101",
        type: "link",
        name: "Introduction to Electrical Circuits",
        s3Url: "https://example.com/electrical-circuits",
        status: "approved",
        description: "Overview of basic circuit concepts and laws.",
      ),
    ),
    FileTile(
      file: File(
        id: 2,
        courseCode: "DEF-202",
        type: "book",
        name: "Advanced Structural Design",
        s3Url: "https://example.com/structural-design",
        status: "approved",
        description:
            "Comprehensive reference on modern structural engineering techniques.",
      ),
    ),
    FileTile(
      file: File(
        id: 3,
        courseCode: "GHI-303",
        type: "notes",
        name: "Mathematical Methods for Engineers",
        s3Url: "https://example.com/math-methods-notes",
        status: "approved",
        description:
            "Handwritten notes covering Laplace transforms, PDEs, and Fourier series.",
      ),
    ),
    FileTile(
      file: File(
        id: 4,
        courseCode: "JKL-404",
        type: "pyqs",
        name: "Past Year Papers - Thermodynamics",
        s3Url: "https://example.com/thermo-pyqs",
        status: "approved",
        description:
            "Collection of past year question papers for thermodynamics.",
      ),
    ),
    FileTile(
      file: File(
        id: 5,
        courseCode: "MNO-505",
        type: "tut",
        name: "Tutorials on Quantum Mechanics",
        s3Url: "https://example.com/qm-tutorials",
        status: "approved",
        description: "Solved tutorials and examples in quantum mechanics.",
      ),
    ),
    FileTile(
      file: File(
        id: 6,
        courseCode: "PQR-606",
        type: "notes",
        name: "Lecture Notes on Fluid Mechanics",
        s3Url: "https://example.com/fluid-notes",
        status: "approved",
        description: "Well-organized notes based on professor’s lectures.",
      ),
    ),
    FileTile(
      file: File(
        id: 7,
        courseCode: "STU-707",
        type: "book",
        name: "Essential Readings on Data Science",
        s3Url: "https://example.com/data-science-readings",
        status: "approved",
        description:
            "Curated readings for foundational topics in data science.",
      ),
    ),
    FileTile(
      file: File(
        id: 8,
        courseCode: "VWX-808",
        type: "pyqs",
        name: "Previous Exams on Structural Analysis",
        s3Url: "https://example.com/structural-analysis-pyqs",
        status: "approved",
        description: "Past structural analysis exams with solutions.",
      ),
    ),
  ];

  static List<FileTile> recentTiles = fileTiles;
  static List<FileTile> bookmarkedTiles = fileTiles;
  static List<FileTile> downloadedTiles = fileTiles;

  static final List<Activity> activities = [
    Activity(
        title: "HC Verma Physics",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.pending,
        message: "message",
        fileType: FileType.notes),
    Activity(
        title: "Landu kumar ke kisse yes bhia ji singh",
        courseCode: "CSN-002",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.pending,
        message: "message",
        fileType: FileType.notes),
    Activity(
        title: "Yes",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.approved,
        message: "message",
        fileType: FileType.tut),
    Activity(
        title: "Sample test title",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.rejected,
        message: "message",
        fileType: FileType.book),
    Activity(
        title: "Mathematics",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.approved,
        message: "message",
        fileType: FileType.link),
    Activity(
        title: "Short",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.pending,
        message: "message",
        fileType: FileType.pyqs),
    Activity(
        title: "HC Verma Physics",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.pending,
        message: "message",
        fileType: FileType.notes),
    Activity(
        title: "Yes",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.approved,
        message: "message",
        fileType: FileType.tut),
    Activity(
        title: "Sample test title",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.rejected,
        message: "message",
        fileType: FileType.book),
    Activity(
        title: "Mathematics",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.approved,
        message: "message",
        fileType: FileType.link),
    Activity(
        title: "Short",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.pending,
        message: "message",
        fileType: FileType.pyqs),
    Activity(
        title: "HC Verma Physics",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.pending,
        message: "message",
        fileType: FileType.notes),
    Activity(
        title: "Yes",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.approved,
        message: "message",
        fileType: FileType.tut),
    Activity(
        title: "Sample test title",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.rejected,
        message: "message",
        fileType: FileType.book),
    Activity(
        title: "Mathematics",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.approved,
        message: "message",
        fileType: FileType.link),
    Activity(
        title: "Short",
        courseCode: "CSN-001",
        date: DateTime(2023, 1, 1, 12, 0, 0),
        status: ActivityStatus.pending,
        message: "message",
        fileType: FileType.pyqs),
  ];
}
