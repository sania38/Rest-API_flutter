import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rest_api/models/contact_model.dart';

class ContactService {
  final Dio _dio = Dio();

  Future<List<Contact>> fetchContacts() async {
    try {
      final response = await _dio.get(
          'https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts');

      debugPrint(response.data.toString());

      // Mengubah data respons menjadi daftar objek Contact
      List<Contact> contacts = [];
      if (response.data is List) {
        for (var item in response.data) {
          contacts.add(Contact.fromJson(item));
        }
      }

      return contacts;
    } catch (e) {
      // Tangani kesalahan di sini
      throw e;
    }
  }

  Future<Contact> fetchContact() async {
    try {
      final response = await _dio.get(
        'https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts/2',
      );

      debugPrint(response.data.toString());

      // Mengubah data respons menjadi objek Contact
      return Contact.fromJson(response.data);
    } catch (e) {
      // Tangani kesalahan di sini
      throw e;
    }
  }

  Future<void> postContact(Contact contact, String phone) async {
    final response = await _dio.post(
      'https://my-json-server.typicode.com/hadihammurabi/flutter-webservice/contacts',
      data: contact.toJson(),
    );
    print(response.data);
  }

  Future<void> update({
    required String title,
    required String body,
  }) async {
    try {
      final Response response = await _dio.put(
        'https://jsonplaceholder.typicode.com/posts/1',
        data: {
          'title': title,
          'body': body,
        },
      );
      debugPrint(response.data.toString());
    } catch (e) {
      // Tangani kesalahan di sini
      throw e;
    }
  }

  Future fetchData() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts/1',
      );

      debugPrint(response.data.toString());

      // Mengubah data respons menjadi objek Contact
      return Contact.fromJson(response.data);
    } catch (e) {
      // Tangani kesalahan di sini
      throw e;
    }
  }
}
