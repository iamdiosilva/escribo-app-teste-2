import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:escribo_app_teste_2/app/core/common/error/exceptions.dart';
import 'package:escribo_app_teste_2/app/modules/bookscase/features/data/datasource/i_download_e_book_datasource.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/common/http_client/enum/request_type.dart';
import '../../../../../core/common/http_client/i_http/i_http_client.dart';

class DownloadEBookDatasourceImpl implements IDownloadEBookDatasource {
  final IHttpClient iHttpClient;

  DownloadEBookDatasourceImpl(this.iHttpClient);

  @override
  Future<String> downloadEbook(String ebookUrl) async {
    String filePath = '';

    if (Platform.isAndroid || Platform.isIOS) {
      String? firstPart;
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      if (allInfo['version']["release"].toString().contains(".")) {
        int indexOfFirstDot = allInfo['version']["release"].indexOf(".");
        firstPart = allInfo['version']["release"].substring(0, indexOfFirstDot);
      } else {
        firstPart = allInfo['version']["release"];
      }
      int intValue = int.parse(firstPart!);

      if (intValue >= 13) {
        filePath = await startDownload(ebookUrl);
      } else {
        if (await Permission.storage.isGranted) {
          await Permission.storage.request();
          filePath = await startDownload(ebookUrl);
        } else {
          filePath = await startDownload(ebookUrl);
        }
      }
    }

    return filePath;
  }

  Future<String> startDownload(String ebookUrl) async {
    final String fileName;

    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    List<String> ebookUrlSliced = ebookUrl.split('/');

    fileName = ebookUrlSliced.last;

    String path = '${appDocDir!.path}/$fileName.epub';

    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await iHttpClient
          .request(
            type: RequestType.DOWNLOAD,
            path: ebookUrl,
            savePath: path,
          )
          .onError((error, stackTrace) =>
              throw const ServerException('Donwload Error'));
      return path;
    }
    return path;
  }
}
