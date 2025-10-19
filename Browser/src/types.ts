// This file imports exports from npm modules that are wrapped in ST in this project.
// This is done to facilitate inspecting their TS types using VSCode.
// This file is not used when running this project.


// ==== Crypto

let aCrypto = window.crypto;
let subtleCrypto = crypto.subtle;
let algorithmIdentifier: Algorithm;
let cryptoKey: CryptoKey;

// AES
let aesGcmParams: AesGcmParams;
let aesCtrParams: AesCtrParams;
let aesCbcParams: AesCbcParams;

// RSA
let rsaOaepParams: RsaOaepParams;
let rsaHashedKeyGenParams: RsaHashedKeyGenParams;
let rsaPssParams: RsaPssParams;

// EC
let ecdhKeyDeriveParams: EcdhKeyDeriveParams;
