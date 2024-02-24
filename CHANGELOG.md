## v1.1.1

### Added

- Movies and Tv Shows credits (casts and crews).

### Patch

- Project structures changes.
  - core
    - re-organize folders
    - redefine [AppSettingsRepo] into [ThemeModeCache] instead.
    - Rename all "use case" classes with "Case" suffix (eg. [GetThemeModeCase] instead of [GetThemeMode]).
  - infrastrucutures
    - rename "service_locator" into "container".
  - interfaces
    - re-organize folders.
    - apply infrastructures changes.
    - Remove [AppNavigator], use typed routes to navigate instead.
      #0911282e1c75e34b40bb994eed23e6c7aeccef06

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
