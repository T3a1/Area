# 0004. Android client technology

- **Status**: Proposed (to be accepted after the mobile spike, target 2026-11-26)
- **Date**: 2026-11-23
- **Why this deserves a record**: a school rule forbids cross-platform web+mobile frameworks, which removes the most common options and must be explained.

## Context
See [tech-selection-frontend.md](../plan/tech-selection-frontend.md#part-b-android-client). Android only, configurable server address, OAuth on mobile, WCAG AA, two languages, APK built in Docker. React Native, Flutter, Ionic and Compose Multiplatform are **forbidden** by the school.

## Alternatives considered
- **Kotlin + Views (XML)**: stable and well documented; rejected because building many list/detail/settings screens is slower and the declarative model of Compose is closer to the web client.
- **Java + Views**: familiar language; rejected because modern Android libraries (Compose, coroutines, AppAuth samples) are Kotlin-first.

## Decision
**Kotlin + Jetpack Compose** (Material 3), Retrofit client generated from the OpenAPI description, AppAuth with PKCE, DataStore for settings.

## Consequences
- ➕ Fast screen development, built-in accessibility semantics.
- ➖ No iOS version (bonus forgone); accepted.
- ➖ Presentation logic duplicated with the web client; accepted, all rules stay on the server.
