import 'package:ecoveloapp/app/core.dart';

class SettingController extends GetxController {
  late final Rx<LanguageModel> _languageSelected;
  set languageSelected(LanguageModel value) => _languageSelected.value = value;
  LanguageModel get languageSelected => _languageSelected.value;

  LanguageModel? _currentLang;

  final RxBool _confirmed = false.obs;
  set confirmed(bool value) => _confirmed.value = value;
  bool get confirmed => _confirmed.value;

  final RxBool _switchVoice = true.obs;
  set switchVoice(bool value) => _switchVoice.value = value;
  bool get switchVoice => _switchVoice.value;

  final RxList<LanguageModel> _languageSupported = <LanguageModel>[].obs;
  set languageSupported(List<LanguageModel> value) =>
      _languageSupported.value = value;
  // ignore: invalid_use_of_protected_membera, invalid_use_of_protected_member
  List<LanguageModel> get languageSupported => _languageSupported.value;

  late LoginManager _loginManager;

  late final SessionManager _sessionM;

  late final AuthHttpService _authHttpService;

  UserModel? userModel;

  bool isVerified = false;
  bool isProccesingVerify = false;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    _loginManager = Get.find<LoginManager>();
    userModel = _loginManager.getUser();
    isVerified = userModel?.verify ?? false;
    _sessionM = Get.find<SessionManager>();
    _authHttpService = Get.find<AuthHttpService>();
    if (!isVerified) {
      getUser().then((value) {
        if (value) {
          isProccesingVerify = userModel?.proccessing ?? false;
          isLoading = true;
        }
      });
    }

    initLanguageSupported();
    String langCode = Prefs.getString(AppKeys.languageKey);
    _languageSelected = (languageSupported.firstWhereOrNull(
                (element) => element.languageCode == langCode) ??
            languageSupported.first)
        .obs;
    _currentLang = languageSelected;
    switchVoice = Prefs.getBool(AppKeys.voiceMode, defaultValue: true);
    super.onInit();
  }

  Future<bool> getUser() async {
    final result = await _authHttpService.getUser();
    if (result.isSuccess() && result.data != null) {
      _loginManager.saveUser(result.data);
    }
    userModel = _loginManager.getUser();
    Prefs.saveBool(AppKeys.isverify, userModel?.proccessing ?? false);
    return true;
  }

  void initLanguageSupported() {
    languageSupported = <LanguageModel>[
      LanguageModel(
        id: 1,
        name: S.current.english,
        flagIcon: AssetsConst.flagUS,
        languageCode: 'en_US',
      ),
      LanguageModel(
        id: 3,
        name: S.current.vietnamese,
        flagIcon: AssetsConst.flagVietNam,
        languageCode: 'vi_VN',
      ),
    ];
    languageSupported.sort((a, b) => a.name.compareTo(b.name));
  }

  void languageOnChanged(LanguageModel language) {
    confirmed = language.id != _currentLang?.id;
    languageSelected = language;
  }

  Future<void> selectLanguage(LanguageModel language) async {
    confirmed = !confirmed;
    await Prefs.saveString(AppKeys.languageKey, language.languageCode);
  }

  void logoutUser() {
    ProcessingDialog processingDialog = ProcessingDialog.show();
    _loginManager.deleteUser().then(
      (value) async {
        await _authHttpService.logout();
        await _sessionM.cleanSession();
        Prefs.removeKey(AppKeys.isverify);
        processingDialog.hide();
        Get.offAllNamed(Routes.signin);
      },
    );
    processingDialog.hide();
  }
}
