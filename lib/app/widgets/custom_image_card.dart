import 'dart:io';
import 'package:deposits_ecommerce/app/common/utils/exports.dart';

// ignore: must_be_immutable
class ImageSelector extends StatefulWidget {
  ValueChanged<TinyImage>? onSelect;
  double? height, width;
  String? url;
  ImageSelector({Key? key, this.onSelect, this.height, this.width, this.url})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImageSelector();
  }
}

class _ImageSelector extends State<ImageSelector> {
  final picker = ImagePicker();

  File? _image;
  Uint8List? thumbnail;

  @override
  Widget build(BuildContext context) {
    return widget.url != null
        ? Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(2.0),
                image: DecorationImage(
                    image: NetworkImage(widget.url!), fit: BoxFit.cover)),
            width: widget.width ?? 109,
            height: widget.height ?? 120,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.url = null;
                  //  _image = null;
                  //   thumbnail = null;
                  // if (widget.onSelect != null) {
                    widget.onSelect!(TinyImage(
                      picturePath: null,
                      thumbnailData: null,
                    ));
                //   }
                });
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(32)),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        : _image == null
            ? GestureDetector(
                onTap: () async {
                  final files = await picker.getImage(
                    source: ImageSource.gallery,
                    imageQuality: 10,
                  );
                  if (files != null) {
                    final pickedFile = files.path;
                    final thumb = File(pickedFile).readAsBytesSync();
                    final bytes =
                        File(pickedFile).readAsBytesSync().lengthInBytes;
                    final kb = bytes / 1024;
                    final mb = kb / 1024;
                    // print("file size is $mb");
                    setState(() {
                      _image = File(pickedFile);
                      thumbnail = thumb;
                      final decoded = base64Encode(thumb);
                      // log(decoded);
                      if (widget.onSelect != null) {
                        widget.onSelect!(TinyImage(
                          picturePath: _image!.path,
                          thumbnailData: decoded,
                        ));
                      }
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  width: widget.width ?? 109,
                  height: widget.height ?? 120,
                  child: const Center(
                    child:
                        Icon(Icons.add, color: AppColors.borderColor, size: 40),
                  ),
                ))
            : thumbnail != null
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: MemoryImage(thumbnail!), fit: BoxFit.cover)),
                    width: widget.width ?? 109,
                    height: widget.height ?? 120,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _image = null;
                          thumbnail = null;
                          if (widget.onSelect != null) {
                            widget.onSelect!(TinyImage(
                              picturePath: null,
                              thumbnailData: null,
                            ));
                          }
                        });
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(32)),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
  }
}

class TinyImage {
  final String? picturePath;
  final String? thumbnailData;

  TinyImage({this.picturePath, this.thumbnailData});
}
