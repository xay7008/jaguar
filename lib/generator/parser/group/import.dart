library jaguar.generator.parser.group;

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/src/annotation.dart';

import 'package:jaguar/src/annotations/import.dart' as ant;

import 'package:jaguar/generator/parser/route/import.dart';
import 'package:jaguar/generator/parser/interceptor/import.dart';
import 'package:jaguar/generator/parser/exception_handler/import.dart';

class GroupInfo {
  final ant.Group group;

  GroupInfo(this.group);
}

ant.Group parseGroup(Element element) {
  return element.metadata.map((ElementAnnotation annot) {
    try {
      return instantiateAnnotation(annot);
    } catch (_) {
      //TODO check what exception and decide accordingly
      return null;
    }
  }).firstWhere((dynamic instance) => instance is ant.Group,
      orElse: () => null);
}

List<RouteInfo> collectAllRoutes(
    ClassElement classElement,
    String prefix,
    List<InterceptorInfo> interceptorsParent,
    List<ExceptionHandlerInfo> exceptionsParent) {
  List<RouteInfo> routes =
      collectRoutes(classElement, prefix, interceptorsParent, exceptionsParent);

  classElement.fields
      .map((FieldElement field) {
        ant.Group group = parseGroup(field);

        if (group == null) {
          return null;
        }

        return collectAllRoutes(field.type.element, "$prefix/${group.path}",
            interceptorsParent, exceptionsParent);
      })
      .where((List<RouteInfo> routes) => routes != null)
      .forEach((List<RouteInfo> val) => routes.addAll(val));

  return routes;
}