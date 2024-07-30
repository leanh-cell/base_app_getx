import 'package:com.ikitech.store/app_user/data/remote/response-request/ctv/all_collaborator_register_request_res.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class CollaboratorRegisterController extends GetxController {
  var listRegisterRequest = RxList<CollaboratorRegisterRequest>();
  int currentPage = 1;
  int status = 0;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;

  CollaboratorRegisterController() {
    getAllCollaboratorRegisterRequest(isRefresh: true);
  }

  Future<void> getAllCollaboratorRegisterRequest({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.ctvRepository
            .getAllCollaboratorRegisterRequest(
          page: currentPage,
          status: status,
        );

        if (isRefresh == true) {
          listRegisterRequest(data!.data!.data!);
          listRegisterRequest.refresh();
        } else {
          listRegisterRequest.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateStatusCollaboratorRequest(
      {required int requestId, required int status}) async {
    try {
      var res = await RepositoryManager.ctvRepository
          .updateStatusCollaboratorRequest(
              requestId: requestId, status: status);
     
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
