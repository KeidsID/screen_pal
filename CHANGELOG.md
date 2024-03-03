## unreleased

### Patch

- remove `google_fonts` package due to an issue:
  [Error: Type 'FontFeature' not found](https://github.com/material-foundation/flutter-packages/issues/568). Replaced
  with local fonts.

## v1.1.1

### Added

- Movies and Tv Shows credits (casts and crews).

### Patch

- Project structures changes.
  - core
    - re-organize folders
    - redefine [AppSettingsRepo] into [ThemeModeCache] instead.
      #b437da2ea18ab60d12f1b8ef82aa60f7b11b4eae
    - Rename all "use case" classes with "Case" suffix (eg. [GetThemeModeCase]
      instead of [GetThemeMode]). #807c72c505b17f1e564ec183d9107b006b79ef36
  - infrastrucutures
    - re-organize folders. #86acabd933fad083eae31fffbc42718be62a8a5e
    - rename "service_locator" into "container".
  - interfaces
    - re-organize folders.
    - apply infrastructures changes.
    - Remove [AppNavigator], use typed routes to navigate instead.
      #dcf00daba45ef5cd2e2b2375c0ae89a15192bc64

## v1.0.1

### Changed

- Better "Last season section" UI on mobile device.
- Better "image at carousel" UI on tablet/dekstop device.
- Better navigation UX and performance.

## v1.0.0 - initial release

### Added

- Movies feature.
- Tv Shows feature.
- App theme feature.
