import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_gen/services/gambar_service.dart';

class DiceBearAvatar extends StatefulWidget {
  @override
  _DiceBearAvatarState createState() => _DiceBearAvatarState();
}

class _DiceBearAvatarState extends State<DiceBearAvatar> {
  String _avatarUrl = "";
  final AvatarService _avatarService = AvatarService();

  void _fetchAvatar() async {
    try {
      final avatarUrl = await _avatarService.fetchAvatar();
      setState(() {
        _avatarUrl = avatarUrl;
      });
    } catch (error) {
      print('Error fetching avatar: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAvatar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DiceBear API'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _avatarUrl.isNotEmpty
                ? SvgPicture.string(
                    _avatarUrl,
                    width: 200,
                    height: 200,
                    placeholderBuilder: (BuildContext context) =>
                        const CircularProgressIndicator(),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
