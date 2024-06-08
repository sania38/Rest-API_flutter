# Rest API Client

## Rest API

> REST API (adalah singkatan dari Representational State Transfer Application Programming Interface). Rest API adalah sebuah arsitektur yang memisahkan antara logika bisnis dengan tampilan dengan menggunakan HTTP request. prosesnya adalah REST API sebagai penengah antara client dan server, dimana client mengirimkan request ke API dengan method GET,POST,PUT,DELETE kemudian API mengambil data dari server, kemudian server mengirimkan data yang diminta dan API memberikan ke client dalam bentuk JSON data.

## HTTP

> HTTP merupakan protokol yang digunakan untuk berkirim data pada internet dan data tersebut berbentuk media web. pola komunikasinya adalah client mengirimkan request ke server kemudian server mengolah an membalas dengan memberi response.
> Struktur request ada
>
> - URL
> - Method(GET, POST, PUT, DELETE)
> - Header
> - Body
>
> Struktur Response ada
>
> - Status code
> - Header
> - Body

## Dio

> Dio berperan sebagai HTTP client yang memungkinkan aplikasi klien untuk berkomunikasi dengan API yang tersedia di server. Dio menyediakan berbagai fitur yang mempermudah pengembang dalam melakukan permintaan HTTP seperti mengelola permintaan, menangani respons, mengelola cookies, dan banyak lagi.

> Dengan menggunakan Dio, pengembang dapat dengan mudah membuat permintaan HTTP ke API, mengirim data, dan memproses respons yang diterima dari server API tersebut. Ini memungkinkan aplikasi klien untuk berinteraksi dengan data yang tersedia di server, seperti mengambil data, mengirim data baru, memperbarui data, atau menghapus data.

> Penggunaan dio adalah sebagai berikut:
>
> - menambahkan dependensi di pubspec.yaml

```dart
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  dio: ^5.4.3+1
  flutter_svg: ^2.0.10+1
```

> - Cara menggunakan dio

```dart
import 'package:dio/dio.dart';

void fetchData() async {
  try {
    // Membuat objek Dio
    Dio dio = Dio();

    // Mengirim permintaan HTTP GET ke URL tertentu
    Response response = await dio.get('https://api.example.com/data');

    // Mengambil data dari respons
    Map<String, dynamic> data = response.data;

    // Menampilkan data
    print(data);
  } catch (e) {
    // Menangani kesalahan jika terjadi
    print('Terjadi kesalahan: $e');
  }
}
```

## Serialisasi & Deserialisasi JSON

> Serialisasi dan deserialisasi JSON adalah proses mengonversi data dari bentuk objek atau struktur data yang ada di dalam aplikasi menjadi format JSON (serialisasi), dan sebaliknya, mengonversi data dari format JSON menjadi bentuk objek atau struktur data yang bisa digunakan di dalam aplikasi (deserialisasi).
>
> - Serialisasi JSON
>   proses mengambil objek atau struktur data dalam aplikasi dan mengonversinya menjadi format JSON. Dalam konteks Flutter atau Dart, hal ini sering dilakukan saat Anda ingin mengirim data ke server dalam permintaan HTTP atau menyimpan data dalam format JSON di penyimpanan lokal seperti shared preferences atau file.Contoh Serialisasi JSON dalam Dart:

```dart
import 'dart:convert';

Map<String, dynamic> data = {
  'name': 'John Doe',
  'age': 30,
  'email': 'john@example.com'
};

// Mengonversi objek Dart menjadi JSON
String jsonStr = jsonEncode(data);

//hasilnya
{"name":"John Doe","age":30,"email":"john@example.com"}

```

> - Deserialisasi JSON
>   proses mengambil data JSON dari server atau penyimpanan lokal dan mengonversinya kembali menjadi objek atau struktur data dalam aplikasi. Ini sangat umum dilakukan ketika Anda menerima respons dari permintaan HTTP ke server dan perlu mengonversi data JSON yang diterima ke dalam objek Dart yang bisa digunakan di dalam aplikasi.Contoh Deserialisasi JSON dalam Dart:

```dart
// Data JSON yang diterima dari server
String jsonString = '{"name":"John Doe","age":30,"email":"john@example.com"}';

// Mengonversi JSON menjadi objek Dart
Map<String, dynamic> decodedData = jsonDecode(jsonString);

// Mengakses data di dalam objek Dart
print(decodedData['name']); // Output: John Doe


```

## Consume REST API (GET, POST, PUT/PATCH, DELETE)

> Contoh consume api dengan dio

```dart
import 'package:dio/dio.dart';

void fetchGetRequest() async {
  try {
    // Membuat objek Dio
    Dio dio = Dio();

    // Mengirim permintaan HTTP GET ke URL tertentu
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');

    // Mengambil data dari respons
    Map<String, dynamic> data = response.data;

    // Menampilkan data
    print('GET Request: $data');
  } catch (e) {
    // Menangani kesalahan jika terjadi
    print('Terjadi kesalahan pada GET request: $e');
  }
}

void fetchPostRequest() async {
  try {
    // Membuat objek Dio
    Dio dio = Dio();

    // Data yang akan dikirimkan dalam permintaan POST
    Map<String, dynamic> postData = {
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    };

    // Mengirim permintaan HTTP POST ke URL tertentu dengan data yang ditentukan
    Response response = await dio.post('https://jsonplaceholder.typicode.com/posts', data: postData);

    // Mengambil data dari respons
    Map<String, dynamic> data = response.data;

    // Menampilkan data
    print('POST Request: $data');
  } catch (e) {
    // Menangani kesalahan jika terjadi
    print('Terjadi kesalahan pada POST request: $e');
  }
}

void fetchPutRequest() async {
  try {
    // Membuat objek Dio
    Dio dio = Dio();

    // Data yang akan dikirimkan dalam permintaan PUT
    Map<String, dynamic> putData = {
      'id': 1,
      'title': 'foo',
      'body': 'bar',
      'userId': 1,
    };

    // Mengirim permintaan HTTP PUT ke URL tertentu dengan data yang ditentukan
    Response response = await dio.put('https://jsonplaceholder.typicode.com/posts/1', data: putData);

    // Mengambil data dari respons
    Map<String, dynamic> data = response.data;

    // Menampilkan data
    print('PUT Request: $data');
  } catch (e) {
    // Menangani kesalahan jika terjadi
    print('Terjadi kesalahan pada PUT request: $e');
  }
}

void fetchDeleteRequest() async {
  try {
    // Membuat objek Dio
    Dio dio = Dio();

    // Mengirim permintaan HTTP DELETE ke URL tertentu
    Response response = await dio.delete('https://jsonplaceholder.typicode.com/posts/1');

    // Menampilkan pesan sukses jika penghapusan berhasil
    if (response.statusCode == 200) {
      print('DELETE Request: Berhasil menghapus data');
    } else {
      print('DELETE Request: Gagal menghapus data');
    }
  } catch (e) {
    // Menangani kesalahan jika terjadi
    print('Terjadi kesalahan pada DELETE request: $e');
  }
}
```
