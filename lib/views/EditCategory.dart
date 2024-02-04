import 'package:flutter/material.dart';
import '/models/flashcard.dart';
//import '/utils/db_helper.dart';

class EditCategoryPage extends StatefulWidget {
  final Category? category;

  EditCategoryPage({this.category});

  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final categoryController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      categoryController.text = widget.category!.title;
      isEditing = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text(isEditing ? "Edit Category" : "Add Category"),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category Name'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                ),
                onPressed: () async {
                  if (isEditing) {
                    final updatedCategory = Category(
                      id: widget.category!.id,
                      title: categoryController.text,
                    );
                    await updatedCategory.update();
                  } else {
                    final newCategory =
                        Category(title: categoryController.text);
                    await newCategory.save();
                  }

                  Navigator.pop(context, true);
                },
                child: Text(isEditing ? 'Save' : 'Add Category'),
              ),
              if (isEditing)
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                  ),
                  onPressed: () async {
                    await widget.category!.delete();
                    Navigator.pop(context, true);
                  },
                  child: Text('Delete'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
