import 'package:aplikasi_5sic3_mobile3/database/database_helper.dart';
import 'package:aplikasi_5sic3_mobile3/models/user_model.dart';
import 'package:aplikasi_5sic3_mobile3/views/home/home_view.dart';
import 'package:flutter/material.dart';

class LoginController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final db = DatabaseHelper();
  bool isVisible = false;
  final formKey = GlobalKey<FormState>();

  void tampilPassword() {
    isVisible = !isVisible;
  }

  String? cekInputan({required String? value, required String label}) {
    if (value!.isEmpty) {
      return "$label wajib diisi.";
    }
    return null;
  }

  // Fungsi Login
  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    try {
      var response = await db.login(
        UserModel(
          userName: usernameController.text,
          userPassword: passwordController.text,
        ),
      );

      if (!context.mounted) return;

      if (response == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Login success'),
            backgroundColor: Colors.teal[400],
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
        // Navigasi ke halaman Notes jika login berhasil
        // akan dibuat nanti setelah halaman Notes dibuat
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username & Password Salah.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed! Please try again.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
