import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_gen/services/image_service.dart';

class ImageGen extends StatefulWidget {
  const ImageGen({Key? key}) : super(key: key);

  @override
  State<ImageGen> createState() => _ImageGenState();
}

class _ImageGenState extends State<ImageGen> {
  final TextEditingController inputController = TextEditingController();
  String? svgString;
  final String noImageUrl = 'https://via.placeholder.com/400x300?text=No+Image';
  final AvatarService _avatarService = AvatarService();

  Future<void> generateImage() async {
    String styleName = 'bottts'; // Nama gaya avatar
    String? seed =
        inputController.text.isNotEmpty ? inputController.text : null;
    print('Style Name: $styleName');
    print('Seed: $seed');
    String? generatedSvg = await _avatarService.generateAvatar(styleName, seed);
    setState(() {
      svgString = generatedSvg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Image Generator",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (svgString != null) // Tampilkan gambar jika svgString tidak null
              SvgPicture.string(
                svgString!,
                height: 300,
                width: 400,
              ) // Menampilkan gambar SVG
            else // Tampilkan placeholder "no image" jika svgString null
              Image.network(noImageUrl), // Menampilkan placeholder "no image"
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: inputController,
              decoration: const InputDecoration(
                labelText: 'Masukkan nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                generateImage();
              },
              child: const Text("Generate"),
            ),
          ],
        ),
      ),
    );
  }
}
