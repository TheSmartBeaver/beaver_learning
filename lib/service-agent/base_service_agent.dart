import 'package:beaver_learning/src/utils/exception_functions.dart';
import 'package:flutter/material.dart';

class BaseServiceAgent {
  final BuildContext buildContext;

  BaseServiceAgent(this.buildContext);

  void dealWithRequestError(BuildContext context, Object? exceptionDetails) {
    dealWithExceptionError(context, exceptionDetails);
  }
}
