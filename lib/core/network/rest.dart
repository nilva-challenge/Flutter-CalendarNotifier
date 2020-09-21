import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as parser;
import 'package:connectivity/connectivity.dart';

class _RestProperties {
  static bool isErrorsOnServer = true;
  static Map<String, Map<String, String>> errorMessages = {};
  static Map<String, String> commonErrors = {};
  static String urlIgnorePart;
  static List<String> errorParameter;
  static bool useMockClient = false;
  static http.BaseClient mockClient;
}

class RestResponse {
  final dynamic headers;
  final dynamic body;
  final dynamic appropriateErrorMessage;
  final int statusCode;

  RestResponse(
      {this.appropriateErrorMessage, this.body, this.headers, this.statusCode});
}

void initErrorMessages(
    String urlIgnorePart,
    Map<String, Map<String, String>> eMessages,
    Map<String, String> commonErros) {
  _RestProperties.isErrorsOnServer = false;
  _RestProperties.errorMessages = eMessages;
  _RestProperties.urlIgnorePart = urlIgnorePart;
  _RestProperties.errorParameter = null;
  _RestProperties.commonErrors = commonErros;
}

void setMockClient(http.BaseClient client) {
  _RestProperties.mockClient = client;
  _RestProperties.useMockClient = client != null;
}

dynamic _mapifyDynamic(dynamic body) {
  try {
    body = body as List<dynamic>;
    for (int i = 0; i < body.length; i++) {
      body[i] = _mapifyDynamic(body[i]);
    }
    return body;
  } catch (err) {
    try {
      body = body as Map<dynamic, dynamic>;
      body.keys.forEach((key) {
        body[key] = _mapifyDynamic(body[key]);
      });
      return body;
    } catch (err1) {
      return body;
    }
  }
}

String _getError({statusCode, url, body}) {
  String error;
  try {
    error = statusCode > 200
        ? _RestProperties.errorMessages[url][statusCode.toString()]
        : null;
  } catch (err) {
    print('We dont have error String for : $statusCode $url');
    print('Body : $body');
  }
  return error;
}

Future<RestResponse> get(String url, {headers}) async {
  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw 'No Internet Connection';
    }
    Map<String, String> jsonHeader = {'Content-Type': 'application/json'};
    if (headers != null)
      (headers as Map<String, dynamic>).keys.forEach((key) {
        jsonHeader.putIfAbsent(key, () => headers[key]);
      });

    return await (_RestProperties.useMockClient
            ? _RestProperties.mockClient.get(url, headers: jsonHeader)
            : http.get(url, headers: jsonHeader))
        .then((res) {
      String error =
          _getError(statusCode: res.statusCode, url: url, body: res.body);
      if (res.statusCode > 200 && error == null) {
        error = _RestProperties.commonErrors['911'];
      }
      return RestResponse(
          appropriateErrorMessage: error,
          body: _mapifyDynamic(json.decode(res.body)),
          headers: res.headers,
          statusCode: res.statusCode);
    }).catchError((err) {
      return RestResponse(
          statusCode: 500,
          appropriateErrorMessage: _RestProperties.commonErrors['500'],
          body: null,
          headers: null);
    });
  } catch (err) {
    return RestResponse(
        statusCode: 912,
        appropriateErrorMessage:
            "Error in creating or sending request or recieving response: $err",
        body: null,
        headers: null);
  }
}

Future<RestResponse> post(String url,
    {headers, body, fileArgument, fileType}) async {
  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw 'No Internet Connection';
    }
    /* Map<String, String> jsonHeader = {'Content-Type': 'application/json'};
    if (headers != null)
      (headers as Map<String, dynamic>).keys.forEach((key) {
        jsonHeader.putIfAbsent(key, () => headers[key]);
      }); */
    if (fileArgument != null && !_RestProperties.useMockClient) {
      if (body[fileArgument] != null && body[fileArgument].length != 0) {
        http.MultipartRequest request =
            http.MultipartRequest('POST', Uri.parse(url));
        headers.keys.forEach((k) {
          request.headers.putIfAbsent(k, () => headers[k]);
        });
        await Future.forEach(body.keys, (k) async {
          if (k != fileArgument) {
            request.fields[k] = body[k].toString();
            return;
          }
          bool isList;
          try {
            body[k] as List<dynamic>;
            isList = true;
          } catch (err) {
            isList = false;
          }
          if (!isList) {
            request.files.add(
              await http.MultipartFile.fromPath(
                k,
                body[k],
                contentType: parser.MediaType.parse(fileType),
              ),
            );
            return;
          } else {
            await Future.forEach(body[k], (v) async {
              request.files.add(
                await http.MultipartFile.fromPath(
                  k,
                  v,
                  contentType: parser.MediaType.parse(fileType),
                ),
              );
            });
          }
        });
        try {
          http.StreamedResponse response = await request.send();
          String body = await response.stream.bytesToString();
          String error =
              _getError(body: body, statusCode: response.statusCode, url: url);
          return RestResponse(
              appropriateErrorMessage: error,
              body: _mapifyDynamic(json.decode(body)),
              headers: request.headers,
              statusCode: response.statusCode);
        } catch (res) {
          return RestResponse(
              statusCode: 912,
              appropriateErrorMessage:
                  "Error in creating or sending request or recieving response: $res",
              body: null,
              headers: null);
        }
      }
    }
    if (fileArgument != null && !_RestProperties.useMockClient)
      body.remove(fileArgument);
    return await (_RestProperties.useMockClient
            ? _RestProperties.mockClient.post(url, headers: headers, body: body)
            : http.post(url, headers: headers, body: body))
        .then((res) {
      String error =
          _getError(statusCode: res.statusCode, url: url, body: res.body);
      if (res.statusCode > 200 && error == null) {
        error = _RestProperties.commonErrors['911'];
      }
      return RestResponse(
          appropriateErrorMessage: error,
          body: _mapifyDynamic(json.decode(res.body)),
          headers: res.headers,
          statusCode: res.statusCode);
    }).catchError((err) {
      return RestResponse(
          statusCode: 912,
          appropriateErrorMessage:
              "Error in creating or sending request or recieving response: $err",
          body: null,
          headers: null);
    });
  } catch (err) {
    return RestResponse(
        statusCode: 912,
        appropriateErrorMessage:
            "Error in creating or sending request or recieving response: $err",
        body: null,
        headers: null);
  }
}

Future<RestResponse> delete(String url, {headers}) async {
  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw 'No Internet Connection';
    }
    /* Map<String, String> jsonHeader = {'Content-Type': 'application/json'};
    if (headers != null)
      (headers as Map<String, dynamic>).keys.forEach((key) {
        jsonHeader.putIfAbsent(key, () => headers[key]);
      }); */
    return await (_RestProperties.useMockClient
            ? _RestProperties.mockClient.delete(url, headers: headers)
            : http.delete(url, headers: headers))
        .then((res) {
      String error =
          _getError(statusCode: res.statusCode, url: url, body: res.body);
      if (res.statusCode > 200 && error == null) {
        error = _RestProperties.commonErrors['911'];
      }
      return RestResponse(
          appropriateErrorMessage: error,
          body: _mapifyDynamic(json.decode(res.body)),
          headers: res.headers,
          statusCode: res.statusCode);
    }).catchError((err) {
      return RestResponse(
          statusCode: 912,
          appropriateErrorMessage:
              "Error in creating or sending request or recieving response: $err",
          body: null,
          headers: null);
    });
  } catch (err) {
    return RestResponse(
        statusCode: 912,
        appropriateErrorMessage:
            "Error in creating or sending request or recieving response: $err",
        body: null,
        headers: null);
  }
}
