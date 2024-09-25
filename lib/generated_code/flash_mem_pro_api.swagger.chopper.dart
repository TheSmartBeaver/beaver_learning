// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_mem_pro_api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$FlashMemProApi extends FlashMemProApi {
  _$FlashMemProApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = FlashMemProApi;

  @override
  Future<Response<AuthenticateDto>> _apiAppUserAuthentificatePost(
      {required AuthenticateEntryDto? body}) {
    final Uri $url = Uri.parse('/api/AppUser/authentificate');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AuthenticateDto, AuthenticateDto>($request);
  }

  @override
  Future<Response<dynamic>> _apiExampleGetExamplePost() {
    final Uri $url = Uri.parse('/api/Example/getExample');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiPopulatePopulatePost() {
    final Uri $url = Uri.parse('/api/Populate/populate');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiPopulateDepopulatePost() {
    final Uri $url = Uri.parse('/api/Populate/depopulate');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiSynchronizeSynchronizePost() {
    final Uri $url = Uri.parse('/api/Synchronize/synchronize');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<DateTime>> _apiSynchronizeGetLastSynchronizationDateGet() {
    final Uri $url = Uri.parse('/api/Synchronize/getLastSynchronizationDate');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<DateTime, DateTime>($request);
  }
}
