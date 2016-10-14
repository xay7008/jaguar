// GENERATED CODE - DO NOT MODIFY BY HAND

part of jaguar.src.interceptors.post;

// **************************************************************************
// Generator: PostInterceptorGenerator
// Target: encodeStringToJson
// **************************************************************************

class EncodeStringToJson extends PostInterceptor {
  const EncodeStringToJson()
      : super(
          returnType: 'void',
          functionName: 'encodeStringToJson',
          parameters: const <Parameter>[
            const Parameter(type: HttpRequest, name: 'request'),
            const Parameter(type: String, name: 'result'),
          ],
          allowMultiple: false,
          takeResponse: true,
        );
}

// **************************************************************************
// Generator: PostInterceptorGenerator
// Target: encodeMapOrListToJson
// **************************************************************************

class EncodeMapOrListToJson extends PostInterceptor {
  const EncodeMapOrListToJson()
      : super(
          returnType: 'void',
          functionName: 'encodeMapOrListToJson',
          parameters: const <Parameter>[
            const Parameter(type: HttpRequest, name: 'request'),
            const Parameter(type: dynamic, name: 'result'),
          ],
          allowMultiple: false,
          takeResponse: true,
        );
}