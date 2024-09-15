import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  var notes = <String, String>{}.obs;
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var isDarkMode = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadTheme();
    loadNotes();

  }


  void addNote(String title, String content) {
    if(notes.containsKey(title)){
      Get.snackbar(
          'Error',
          'title is defined before!!',

      );
    }
    else{
    notes[title] = content;
    saveNotes();
  }}


  void editNote(String oldTitle, String newTitle, String newContent) {
    if (notes.containsKey(oldTitle)) {

        notes.remove(oldTitle);
        notes[newTitle] = newContent;
        saveNotes();
      }

  }


  void deleteNote(String title) {
    notes.remove(title);
    saveNotes();
  }


  void saveNotes() {
    box.write('notes', notes);
  }

  void loadNotes()  {


    var storedNotes = box.read<Map<dynamic, dynamic>>('notes');

    if (storedNotes != null) {

      notes.addAll(storedNotes.map((key, value) => MapEntry(key.toString(), value.toString())));
    }
  }

  void toggleTheme(bool isDark) {
    isDarkMode.value = isDark;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    box.write('isDarkMode', isDark);
  }

  void loadTheme(){

    bool isDarkMode=box.read('isDarkMode')?? false;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark: ThemeMode.light);

  }



  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
