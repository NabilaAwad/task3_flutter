import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});


  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFFFC0CB),
        actions: [
          Obx(() => Switch(
            value: controller.isDarkMode.value,  // مراقبة الثيم
            onChanged: (value) {
              controller.toggleTheme(value);  // تبديل الثيم عند الضغط
            },
            activeColor: Colors.white,
          )),
        ],
      ),
      body: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.8,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(8),


        child: Obx(() {
          if (controller.notes.isEmpty) {
            return Center(
              child: Text(
                'No Notes Available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.notes.length,
            itemBuilder: (context, index) {
              String title = controller.notes.keys.elementAt(index);
              String content = controller.notes[title]!;

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
               child: ListTile(
                 leading: Icon(Icons.notes, color: Colors.grey[600]),
                  title: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(content, maxLines: 1, overflow: TextOverflow.ellipsis),
                  onTap: () {
                    Get.defaultDialog(
                      title: 'Note Details',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title: $title',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Content: $content',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      barrierDismissible: true,
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit_note, color: Colors.blueAccent),
                        onPressed: () {
                          controller.titleController.text = title;
                          controller.contentController.text = content;
                          Get.defaultDialog(
                            title: 'Edit Note',
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  decoration: InputDecoration(labelText: 'Title'),
                                  controller: controller.titleController,
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  decoration: InputDecoration(labelText: 'Content'),
                                  controller: controller.contentController,
                                  maxLines: 5,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        var newTitle = controller.titleController.text;
                                        var newContent = controller.contentController.text;
                                        controller.editNote(title, newTitle, newContent);
                                        Get.back();
                                      },
                                      child: Text('Save'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFFFC0CB),
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('Cancel'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            barrierDismissible: true,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          controller.deleteNote(title);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add_sharp, color: Colors.white),
        backgroundColor: Color(0xFFFFC0CB),
        onPressed: () {
          Get.defaultDialog(
            title: 'Add New Note',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  controller: controller.titleController,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  controller: controller.contentController,
                  maxLines: 5,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        var title = controller.titleController.text;
                        var content = controller.contentController.text;
                        if (title.isNotEmpty && content.isNotEmpty) {
                          controller.addNote(title, content);
                          Get.back();
                        } else {
                          Get.snackbar('Error', 'Title and content cannot be empty');
                        }
                      },
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFC0CB),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            barrierDismissible: true,
          );
        },
      ),
    );
  }
}