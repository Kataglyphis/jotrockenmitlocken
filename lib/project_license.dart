import 'package:anthology/Licenses/bundled_licenses.dart';

/// The repository's own licence, bundled from its root by `pubspec.yaml`.
const String projectLicensePath = 'LICENSE';

/// The name the licences page lists this app's own licence under.
const String projectLicensePackage = 'jotrockenmitlocken';

/// Lists the app's own licence beside its dependencies' on the licences page.
void registerProjectLicense() {
  registerAssetLicense(<String>[projectLicensePackage], projectLicensePath);
}
