# Flutter Http Caching

Widgets that make it easy to integrate API caching into [Flutter](https://flutter.dev). Built to
work with [package:http](https://pub.dev/packages/http) and
uses [package:sqflite](https://pub.dev/packages/sqflite).This package contains a set of functions
that make it easy to consume HTTP resources.

## Platform Support

| Android |  iOS  | MacOS |  Web  | Linux | Windows |
| :-----: | :---: | :---: | :---: | :---: | :-----: |
|   ✔️   |   ✔️   |   ✔️   |     |       |         |

## Getting Started

In your flutter project add the dependency in your pubspec.yaml file:

```yml
dependencies:
  ...
   flutter_http_caching:
```

## Getting Started

This package contains three functions which returns http response.

- `httpGet` : it stores request and response from get method.
- `httpPut`: it stores request and response from Put method.
- `httpPost`: it stores request and response from post method .
- `httpPatch`: it stores request and response from patch method.
- `httpDelete`: it stores request and response from delete method.

Each of these take instance of `HTTP Client` and `Url` as required field and also has `header` and
`body` as optional fields.We have created a custom interceptor for logging request which user can
use by passing `isLogging` true and user can also pass custom interceptor in `interceptors` which
accept list of interceptors.

## Usage

Import `flutter_http_caching.dart`

```dart
import 'package:flutter_http_caching/flutter_http_caching.dart';
```

Create Http Client variable

```dart

var client = http.Client();
```

get the http response using http_caching functions

```dart

var response = httpGet(client, url: baseUrl);
```

add custom interceptor
```dart

var response = httpGet(client, url: baseUrl,interceptors: [customInterceptor()]);
```

## Thank You

We greatly appreciate any contributions to the project which can be as simple as providing feedback
on the API or documentation.

## You can also click on the "Thumb up" button of the top of the [pub.dev page](https://pub.dev/packages/flutter_http_caching) if you find this Package helpfull.

### Team [CREO IT](https://www.creoit.com/)