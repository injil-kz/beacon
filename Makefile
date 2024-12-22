version:
	cd packages/beacon && cider bump patch
	cd packages/beacon_dio_adapter && cider bump patch
	cd packages/beacon_mobile_inspector && cider bump patch

pub_analyze:
	cd packages/beacon && flutter pub publish --dry-run
	cd packages/beacon_dio_adapter && flutter pub publish --dry-run
	cd packages/beacon_mobile_inspector && flutter pub publish --dry-run

get:
	dart pub get

format:
	dart format . --line-length=120