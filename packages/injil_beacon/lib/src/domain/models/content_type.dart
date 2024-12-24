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
  imageAvif('image/avif');

  const BeaconContentType(this.header);

  final String header;

  static bool isImage(String contentType) {
    return contentType.contains('image/');
  }
}
