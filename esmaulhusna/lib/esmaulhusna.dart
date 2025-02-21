
import 'esmaulhusna_platform_interface.dart';

class Esmaulhusna {
  Future<String?> getPlatformVersion() {
    return EsmaulhusnaPlatform.instance.getPlatformVersion();
  }
}
