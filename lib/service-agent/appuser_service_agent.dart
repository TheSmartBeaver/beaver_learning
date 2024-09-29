import 'package:beaver_learning/api/flash_mem_pro_api.dart';
import 'package:beaver_learning/generated_code/flash_mem_pro_api.swagger.dart';
import 'package:beaver_learning/service-agent/base_service_agent.dart';
import 'package:beaver_learning/src/utils/synchronize_functions.dart';

class AppUserServiceAgent extends BaseServiceAgent {
  AppUserServiceAgent(super.buildContext);

  Future<AuthenticateDto> authenticate(AuthenticateEntryDto dto) async {

    var response = await fmpApi.apiAppUserAuthentificatePost(body: dto);

    if (response.error != null) {
      dealWithRequestError(buildContext, response.error);
      throw Exception("");
    } else {
      return response.body!;
    }
  }

  Future<DateTime> getLastServerUserSyncDate() async {
    var response = (await fmpApi.apiSynchronizeGetLastServerSynchronizationDateGet());

    if (response.error != null) {
      dealWithRequestError(buildContext, response.error);
      throw Exception("");
    } else {
      return response.body!;
    }
  }

  Future setLastServerUserSyncDate() async {
    var response = (await fmpApi.apiSynchronizeSetLastServerSynchronizationDateGet(newSynchronizationDate: getUpdateDateNow()));

    if (response.error != null) {
      dealWithRequestError(buildContext, response.error);
      throw Exception("");
    } else {
      return response.body!;
    }
  }

  Future<ElementsWithoutSkuDto> createElementsWithMissingSku(ElementsWithoutSkuDto dto) async {
    var response = (await fmpApi.apiSynchronizeCreateElementsWithMissingSkuPost(body: dto));

    if (response.error != null) {
      dealWithRequestError(buildContext, response.error);
      throw Exception("");
    } else {
      return response.body!;
    }
  }

  Future<dynamic> synchronizeElementsTowardsServerUpdate(ElementsToSyncDto dto) async {
    var response = (await fmpApi.apiSynchronizeSynchronizeElementsTowardsServerPost(body: dto));

    if (response.error != null) {
      dealWithRequestError(buildContext, response.error);
      throw Exception("");
    } else {
      return response.body!;
    }
  }

  Future<ElementsToSyncDto> synchronizeElementsTowardsMobileUpdate(DateTime lastMobileUpdate) async {
    var response = (await fmpApi.apiSynchronizeSynchronizeElementsTowardsMobilePost(lastMobileUpdate: lastMobileUpdate));

    if (response.error != null) {
      dealWithRequestError(buildContext, response.error);
      throw Exception("");
    } else {
      return response.body!;
    }
  }
}
