
### Useful commands
format:
	find . -not -path './.git/*' -not -path '*/.dart_tool/*' -not -path '*./common/l10n/lib/src/*' -name "*.dart" ! -name "*.g.dart" ! -name "*.gr.dart" ! -name "*_test.dart" ! -name '*.swagger.*' ! -name '*.config.dart' ! -name '*.chopper.dart' ! -name '*.freezed.dart' | tr '\n' ' ' | xargs fvm dart format --line-length=120
fix:
	fvm dart fix --apply
clean:
	fvm flutter clean && fvm flutter pub global run melos clean
get:
	fvm flutter pub get
generate:
	fvm flutter pub run build_runner build -d
watch:
	fvm flutter packages pub run build_runner watch -d
golden:
	fvm flutter test --update-goldens
test:
	fvm flutter test
upgrade:
	fvm flutter pub upgrade --major-versions
pods:
	arch -x86_64 pod install --project-directory=ios/ --repo-update

remote_pod:
	arch -x86_64 pod update Firebase/RemoteConfig --project-directory=ios/

buildDebug:
	fvm flutter build apk lib/main_stage.dart --debug

dev_build:
	cd android && bundle exec fastlane build_android environment:"lib/main_stage.dart" mode:--debug && cd .. && clear

setup: get generate

prepare: fix format

nolock: find . -name "pubspec.lock" -delete

core: 
	melos exec -- fvm dart pub upgrade efficency && melos exec --  fvm dart pub upgrade magnum_ui_kit && melos exec -- fvm dart pub upgrade core
tsd: 
	fvm dart pub upgrade flutter_datawedge && fvm dart pub upgrade scanwedge

ci_lint_analyze:
	echo "Analyze"
	# fvm dart analyze --fatal-infos
ci_lint_format:
	find . -not -path './.git/*' -not -path '*/.dart_tool/*' -not -path '*/common/l10n/lib/src/generated/*' -not -path '*/lib/l10n/*' -name "*.dart" ! -name "*.g.dart" ! -name "*.gr.dart" ! -name "*_test.dart" ! -name '*.swagger.*' ! -name '*.config.dart' ! -name '*.chopper.dart' ! -name '*.freezed.dart' | tr '\n' ' ' | xargs fvm dart format --line-length=120	--set-exit-if-changed

logs:
	fvm dart run changelog_generator.dart

bird_init:
	sudo shorebird init

bird_apk:
	sudo shorebird release android --target ./lib/main_stage.dart --artifact apk

bird_aab:
	sudo shorebird release android --target ./lib/main_stage.dart --artifact apk

bird_patch_android:
	sudo shorebird patch android --target ./lib/main_stage.dart

bird_patch_ios:
	shorebird patch ios --target ./lib/main_stage.dart --flutter-version=3.13.9 --verbose

bird_list:
	sudo shorebird flutter versions list

bird_use:
	fvm install 3.24.3 && fvm use 3.24.3

bird_ci_apk:
	shorebird release android --target ./lib/main_stage.dart --flutter-version=3.24.3 --artifact apk

bird_ci_ipa:
	shorebird release ios --target ./lib/main_stage.dart --flutter-version=3.24.3 -- --export-options-plist ios/ExportOptions.plist

bird_ipa:
	sudo shorebird release ios --target ./lib/main_stage.dart  
ci_remote_pod:
	pod update Firebase/RemoteConfig --project-directory=ios/
	
ci_bird_patch_android:
	shorebird patch android --target ./lib/main_stage.dart --release-version=2.0.1+5223 --allow-asset-diffs

ci_bird_patch_ios:
	shorebird patch ios --target ./lib/main_stage.dart --release-version=2.0.1+5223 --allow-asset-diffs -- --export-options-plist ios/ExportOptions.plist
