import 'package:aplikasi_5sic3_mobile3/database/database_helper.dart';
import 'package:aplikasi_5sic3_mobile3/models/note_model.dart';
import 'package:flutter/material.dart';

class NoteController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();

  late Future<List<NoteModel>> notes;

  Future<List<NoteModel>> readData() {
    notes = db.readData();
    return notes;
  }

  cekValidasi(String? value, {required String label}) {
    if (value!.isEmpty) {
      return '$label wajib diisi';
    }
    return null;
  }

  Future<void> createData(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    // Perintah Simpan
    try {
      // Perintahnya
      int result = await db.createNote(
        NoteModel(
          noteTitle: titleController.text,
          noteContent: contentController.text,
          createdAt: DateTime.now().toIso8601String(),
        ),
      );

      if (!context.mounted) return;
      if (result > 0) {
        // berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Berhasil Simpan Data.'),
            backgroundColor: Colors.teal[400],
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      } else {
        // Gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Gagal Simpan Data.'),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      // Error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
