// ignore_for_file: public_member_api_docs

enum BeaconContentType {
  applicationJson('application/json'),
  applicationXml('application/xml'),
  applicationFormUrlEncoded('application/x-www-form-urlencoded'),
  applicationOctetStream('application/octet-stream'),
  textPlain('text/plain'),
  textHtml('text/html'),
  textXml('text/xml'),
  textCsv('text/csv'),
  textYaml('text/yaml'),
  textMarkdown('text/markdown'),
  imagePng('image/png'),
  imageJpeg('image/jpeg'),
  imageGif('image/gif'),
  imageSvg('image/svg+xml'),
  imageWebp('image/webp'),
  imageBmp('image/bmp'),
  imageIco('image/x-icon'),
  imageTiff('image/tiff'),
  imageTga('image/tga'),
  imagePsd('image/psd'),
  imageHeif('image/heif'),
  imageAvif('image/avif'),
  other('other');

  const BeaconContentType(this.header);

  final String header;

  static BeaconContentType fromHeader(String contentType) {
    if (contentType.isEmpty) return BeaconContentType.other;
    final normalized = contentType.toLowerCase();
    try {
      return BeaconContentType.values.firstWhere(
        (e) => e != BeaconContentType.other && normalized.contains(e.header),
      );
    } catch (_) {
      return BeaconContentType.other;
    }
  }

  bool get isImage => header.startsWith('image/');
  bool get isJson => header.contains('application/json');
  bool get isFormUrlEncoded => header.contains('application/x-www-form-urlencoded');
}
