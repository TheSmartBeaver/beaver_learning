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
  Future<Response<DateTime>>
      _apiSynchronizeGetLastServerSynchronizationDateGet() {
    final Uri $url =
        Uri.parse('/api/Synchronize/getLastServerSynchronizationDate');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<DateTime, DateTime>($request);
  }

  @override
  Future<Response<dynamic>> _apiSynchronizeSetLastServerSynchronizationDateGet(
      {DateTime? newSynchronizationDate}) {
    final Uri $url =
        Uri.parse('/api/Synchronize/setLastServerSynchronizationDate');
    final Map<String, dynamic> $params = <String, dynamic>{
      'newSynchronizationDate': newSynchronizationDate
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiSynchronizeSyncTowardsServerPost() {
    final Uri $url = Uri.parse('/api/Synchronize/syncTowardsServer');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ElementsWithoutSkuDto>>
      _apiSynchronizeCreateElementsWithMissingSkuPost(
          {required ElementsWithoutSkuDto? body}) {
    final Uri $url = Uri.parse('/api/Synchronize/createElementsWithMissingSku');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ElementsWithoutSkuDto, ElementsWithoutSkuDto>($request);
  }

  @override
  Future<Response<dynamic>> _apiSynchronizeSynchronizeElementsTowardsServerPost(
      {required ElementsToSyncDto? body}) {
    final Uri $url =
        Uri.parse('/api/Synchronize/synchronizeElementsTowardsServer');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ElementsToSyncDto>>
      _apiSynchronizeSynchronizeElementsTowardsMobilePost(
          {DateTime? lastMobileUpdate}) {
    final Uri $url =
        Uri.parse('/api/Synchronize/synchronizeElementsTowardsMobile');
    final Map<String, dynamic> $params = <String, dynamic>{
      'lastMobileUpdate': lastMobileUpdate
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ElementsToSyncDto, ElementsToSyncDto>($request);
  }
}
