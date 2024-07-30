import 'package:com.ikitech.store/app_user/data/remote/response-request/mini_game/all_mini_game-res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/mini_game/gift_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/mini_game/mini_game_res.dart';
import 'package:com.ikitech.store/app_user/model/guess_number_game.dart';
import 'package:com.ikitech.store/app_user/model/mini_game.dart';

import '../../../model/gift.dart';
import '../../../utils/user_info.dart';
import '../../remote/response-request/guess_number_game/all_guess_number_game_res.dart';
import '../../remote/response-request/guess_number_game/guess_number_game_res.dart';
import '../../remote/response-request/mini_game/all_gift_res.dart';
import '../../remote/response-request/success/success_response.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class MiniGameRepository {
  Future<AllMiniGameRes?> getAllMiniGame(
      {required int page, int? status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllMiniGame(UserInfo().getCurrentStoreCode(), page, status);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<MiniGameRes?> getMiniGame({required int id}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getMiniGame(UserInfo().getCurrentStoreCode(), id);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<MiniGameRes?> addMiniGame({required MiniGame miniGame}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addMiniGame(UserInfo().getCurrentStoreCode(), miniGame.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<MiniGameRes?> updateMiniGame(
      {required MiniGame miniGame, required int id}) async {
    try {
      var res = await SahaServiceManager().service!.updateMiniGame(
          UserInfo().getCurrentStoreCode(), id, miniGame.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteMiniGame({required int id}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteMiniGame(UserInfo().getCurrentStoreCode(), id);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllGiftRes?> getAllGift({required int page, required int id}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllGift(UserInfo().getCurrentStoreCode(), id, page);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<GiftRes?> getGift({required int id, required int spinId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getGift(UserInfo().getCurrentStoreCode(), spinId, id);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<GiftRes?> addGift({required Gift gift, required int spinId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addGift(UserInfo().getCurrentStoreCode(), spinId, gift.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<GiftRes?> updateGift(
      {required Gift gift, required int spinId, required int id}) async {
    try {
      var res = await SahaServiceManager().service!.updateGift(
          UserInfo().getCurrentStoreCode(), spinId, id, gift.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteGift(
      {required int spinId, required int id}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteGift(UserInfo().getCurrentStoreCode(), spinId, id);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  //////Guess Number Game
  Future<AllGuessNumberGameRes?> getAllGuessNumberGame(
      {required int page, int? status}) async {
    try {
      var res = await SahaServiceManager().service!.getAllGuessNumberGame(
          UserInfo().getCurrentStoreCode(), page, status);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<GuessNumberGameRes?> getGuessNumberGame({required int id}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getGuessNumberGame(UserInfo().getCurrentStoreCode(), id);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<GuessNumberGameRes?> addGuessNumberGame(
      {required GuessNumberGame guessNumberGame}) async {
    try {
      var res = await SahaServiceManager().service!.addGuessNumberGame(
          UserInfo().getCurrentStoreCode(), guessNumberGame.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<GuessNumberGameRes?> updateGuessNumberGame(
      {required GuessNumberGame guessNumerGame, required int id}) async {
    try {
      var res = await SahaServiceManager().service!.updateGuessNumberGame(
          UserInfo().getCurrentStoreCode(), id, guessNumerGame.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteGuessNumberGame({required int id}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteGuessNumberGame(UserInfo().getCurrentStoreCode(), id);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
