# What About

A simple Flutter app that plays an audio clip on tap. The blue circle in the center acts as a play button and the floating action button lets you stop or resume playback. Long‑press the circle to cycle through playback speeds (0.25×, 0.5×, 1× and 2×).

## Running

Make sure Flutter is installed and run from the project root:

```bash
flutter pub get
flutter run
```

## Building

Generate release builds with the following commands:

```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
```

For an Android App Bundle use `flutter build appbundle`.

## Updating the audio clip

The app plays the file `assets/what_about.mp3`. Replace this file with your own
audio to change the playback:

1. Drop a new `MP3` file in the `assets/` directory.
2. If the file name changes, update `pubspec.yaml` under the `assets:` section.
3. Run `flutter pub get` before rebuilding so the asset is bundled correctly.

### Generating audio with AI

You can create a new sound using any online text‑to‑speech service. Many sites
let you type a phrase and download the generated audio as an MP3. Once
downloaded, save the file as `what_about.mp3` (or update `pubspec.yaml` if you
choose another name) and run the app again.
