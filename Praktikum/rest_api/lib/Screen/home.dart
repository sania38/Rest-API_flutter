import 'package:flutter/material.dart';
import 'package:rest_api/models/contact_model.dart';
import 'package:rest_api/services/contact_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ContactService _contactService = ContactService();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  String updateResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'API TRY',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'name', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                    labelText: 'Phone', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          String name = _nameController.text;
                          String phone = _phoneController.text;
                          Contact contact =
                              Contact(id: 0, name: name, phone: phone);
                          _contactService.postContact(contact, phone);
                        },
                        child: const Text('POST'),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          List<Contact> contacts =
                              await _contactService.fetchContacts();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Contact Info"),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: contacts.map(
                                    (contact) {
                                      return Text(
                                        "Name: ${contact.name}\nPhone: ${contact.phone}",
                                        textAlign: TextAlign.left,
                                      );
                                    },
                                  ).toList(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('GET'),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Contact contact =
                              await _contactService.fetchContact();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Contact Info"),
                                content: Text(
                                  "Name: ${contact.name}\nPhone: ${contact.phone}",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('GET 2'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              String newTitle = "";
                              String newBody = "";
                              return AlertDialog(
                                title: Text("Update Post"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      onChanged: (value) {
                                        newTitle = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "New Title",
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    TextFormField(
                                      onChanged: (value) {
                                        newBody = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "New Body",
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        await _contactService.update(
                                            title: newTitle, body: newBody);
                                        setState(() {
                                          updateResult = "Update successful!";
                                        });
                                      } catch (e) {
                                        setState(() {
                                          updateResult = "Update failed: $e";
                                        });
                                      }
                                      Navigator.of(context).pop();
                                      if (updateResult.isNotEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(updateResult),
                                        ));
                                      }
                                    },
                                    child: Text("Update"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('Update Post'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
