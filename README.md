## react-native-firebaseui-auth

Native FirebaseUI Auth flows for React Native (Android + iOS) with a small JavaScript surface area:

- `signIn(config)` launches the FirebaseUI sign-in experience
- `getCurrentUser()` returns the current Firebase user (or `null`)
- `signOut()` signs out and emits an auth-state event
- `deleteUser()` deletes the currently signed-in user
- `AuthEventEmitter` / `AuthEvents.AUTH_STATE_CHANGED` for auth state changes

## Requirements

- React Native `>= 0.59`
- A Firebase project with Authentication enabled
- Platform-specific Firebase setup completed for your app (not this library):
  - Android: `google-services.json` + Gradle config
  - iOS: `GoogleService-Info.plist` + Firebase initialization

## Install

```bash
npm i react-native-firebaseui-auth
# or
yarn add react-native-firebaseui-auth
```

### iOS

From your app’s `ios/` directory:

```bash
pod install
```

## Usage

```js
import RNFirebaseuiAuth, { AuthEventEmitter, AuthEvents } from 'react-native-firebaseui-auth';

const subscription = AuthEventEmitter.addListener(AuthEvents.AUTH_STATE_CHANGED, (event) => {
  // event.user is either a user object or null
  console.log('Auth state changed', event?.user);
});

async function signIn() {
  const user = await RNFirebaseuiAuth.signIn({
    providers: ['google', 'email'],
    tosUrl: 'https://example.com/terms',
    privacyPolicyUrl: 'https://example.com/privacy',
    allowNewEmailAccounts: true,
    requireDisplayName: true,
    autoUpgradeAnonymousUsers: false,
    customizations: ['theme', 'logo'],
  });

  return user;
}

export function cleanup() {
  subscription.remove();
}
```

## API

### `signIn(config): Promise<User>`

**Config**

- **`providers`**: array of provider identifiers:
  - `anonymous` (exclusive; if present it is used alone)
  - `facebook`
  - `google`
  - `email`
  - `phone`
  - `apple`
  - `yahoo`
  - `github`
  - `twitter`
  - `microsoft`
- **`customizations`** (optional): platform-specific UI customization toggles
  - Android: `theme`, `logo`
  - iOS: `auth_picker`, `email_entry`, `password_sign_in`, `password_sign_up`, `password_recovery`, `password_verification`
- **`tosUrl`** / **`privacyPolicyUrl`** (optional): URLs shown by FirebaseUI
- **`allowNewEmailAccounts`** (optional, default `true`): email provider only
- **`requireDisplayName`** (optional, default `true`): email provider only
- **`autoUpgradeAnonymousUsers`** (optional, default `false`): enable FirebaseUI anonymous user auto-upgrade

### `getCurrentUser(): Promise<User | null>`

Returns the current Firebase user if one is authenticated.

### `signOut(): Promise<boolean>`

Signs out the current user and emits `AuthStateChanged` with `user = null`.

### `deleteUser(): Promise<boolean>`

Deletes the currently signed-in user.

### Events

- **Event name**: `AuthStateChanged`
- **Emitter**: `AuthEventEmitter`
- **Constant**: `AuthEvents.AUTH_STATE_CHANGED`

Payload:

- `event.user`: user object (when signed in) or `null` (when signed out)

## Android customization notes

If you include `customizations: ['theme', 'logo']`, the Android module looks for:

- **Style**: `AuthTheme` (a style in your app)
- **Drawable**: `auth_logo` (a drawable in your app)

## Security and privacy

- Do **not** commit app secrets or signing material (keystores, private keys, service account JSON).
- Do **not** commit your app’s `google-services.json` / `GoogleService-Info.plist` if your policy forbids it.
- This repository should not contain personal emails, donation links, or developer-identifying metadata in published artifacts.

## Contributing

1. Fork the repo and create a feature branch.
2. Keep changes focused and include a brief test plan in your PR description.

## License

MIT. See `LICENSE`.

