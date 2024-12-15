version:
	cd packages/beacon && cider bump patch
	cd packages/beacon_dio_adapter && cider bump patch

pub_analyze:
	cd packages/beacon && flutter pub publish --dry-run
	cd packages/beacon_dio_adapter && flutter pub publish --dry-run