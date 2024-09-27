import 'package:beaver_learning/api/flash_mem_pro_api.dart';
import 'package:beaver_learning/generated_code/flash_mem_pro_api.swagger.dart';
import 'package:beaver_learning/service-agent/base_service_agent.dart';

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

  Future<DateTime> getLastUserSyncDate() async {
    var response = (await fmpApi.apiSynchronizeGetLastSynchronizationDateGet());

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
}
