publish:
	cd packages/injil_beacon && dart pub publish
	cd packages/beacon_dio_adapter && dart pub publish
	cd packages/beacon_mobile_inspector && dart pub publish

version:
	cd packages/injil_beacon && cider bump patch
	cd packages/beacon_dio_adapter && cider bump patch
	cd packages/beacon_mobile_inspector && cider bump patch

pub_analyze:
	cd packages/injil_beacon && flutter pub publish --dry-run
	cd packages/beacon_dio_adapter && flutter pub publish --dry-run
	cd packages/beacon_mobile_inspector && flutter pub publish --dry-run

release:
	cd packages/injil_beacon && flutter pub publish -f
	cd packages/beacon_dio_adapter && flutter pub publish -f
	cd packages/beacon_mobile_inspector && flutter pub publish -f

get:
	dart pub get

fix:
	dart fix --apply

format:
	dart format . --line-length=120