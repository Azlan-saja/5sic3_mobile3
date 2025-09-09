import 'package:aplikasi_5sic3_mobile3/controllers/note_controller.dart';
import 'package:aplikasi_5sic3_mobile3/views/home/create_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final noteController = NoteController();

  @override
  void initState() {
    super.initState();
    noteController.readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Seacrh Note",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                filled: true,
                fillColor: Colors.teal.withAlpha(25),
                contentPadding: EdgeInsets.only(top: 14),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: noteController.readData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final items = snapshot.data;
                  return ListView.builder(
                    itemCount: items!.length,
                    itemBuilder: (context, index) {
                      final dataNote = items[index];
                      return Text(dataNote.noteTitle);
                    },
                  );
                }
                return Text('Kosong');
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateView(),
            ),
          );
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }
}
