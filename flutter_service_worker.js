'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"splash/img/light-4x.png": "0f61e8351932e1d8dc7bc8040a2b088e",
"splash/img/dark-3x.png": "e42a3f9744b8ad1d957340b2f0ac9702",
"splash/img/light-3x.png": "e42a3f9744b8ad1d957340b2f0ac9702",
"splash/img/light-1x.png": "ecd8b4ec817a0543468b8095902aca94",
"splash/img/dark-1x.png": "ecd8b4ec817a0543468b8095902aca94",
"splash/img/light-2x.png": "b8f944d00e00bb5692b5da5784e91276",
"splash/img/dark-2x.png": "b8f944d00e00bb5692b5da5784e91276",
"splash/img/dark-4x.png": "0f61e8351932e1d8dc7bc8040a2b088e",
"index.html": "f7a06346d44e79907db594e4b50c6359",
"/": "f7a06346d44e79907db594e4b50c6359",
"assets/NOTICES": "a8b55088c85bb65270973ebbd90974b5",
"assets/assets/%25EC%259A%25B4%25EC%2588%2598%25EC%25A2%258B%25EC%259D%2580%25EB%2582%25A0.txt": "86e79c9876c4450e07ae48493e1d8301",
"assets/assets/%25ED%259D%25A5%25EB%25B6%2580%25EC%2599%2580%25EB%2586%2580%25EB%25B6%2580.txt": "d1ca9174f687e8d2a398f3d85f372741",
"assets/assets/%25EC%258B%259C%25EA%25B3%25A8%25EC%25A5%2590%25EC%2584%259C%25EC%259A%25B8%25EA%25B5%25AC%25EA%25B2%25BD.txt": "856a4be06e68cd27b3ef8535abcfcadc",
"assets/assets/%25EC%2584%25B1%25EB%2583%25A5%25ED%258C%2594%25EC%259D%25B4%25EC%2586%258C%25EB%2585%2580.txt": "80ca8cf8791f75d32aaa507c728536c7",
"assets/assets/logo_only.png": "a3b7a532cc3b056556f6a2b67536f970",
"assets/assets/chat_selected.svg": "5bb93f31661828601bc961af23e1ce67",
"assets/assets/%25ED%2599%258D%25EA%25B8%25B8%25EB%258F%2599%25EC%25A0%2584.txt": "b4b59fb8807b5eb7c49ed798005c568e",
"assets/assets/home.svg": "c1d72f3e5780693b2f41d6a5b3ab21af",
"assets/assets/characters/ch.2-1.png": "043d3bee927f5bd0cced47350589854d",
"assets/assets/characters/ch.2.png": "70d39d406c0228211221091f50e0f5d0",
"assets/assets/characters/ch.12.png": "4a726ded37e72fa14b9e09a2f8486453",
"assets/assets/characters/ch.4.png": "d6a76abe14d3370fea257306d16a6bc0",
"assets/assets/characters/ch.11-1.png": "64f3e6e4e14195e9659dd45c2488c4bb",
"assets/assets/characters/ch.6.png": "b23f76a8d340a992c8ff7c1415d1173b",
"assets/assets/characters/ch.10-1.png": "d6d889600294b71e4a5756216f25d759",
"assets/assets/characters/ch.5.png": "60f249a555327502e69eeb4856ad3abe",
"assets/assets/characters/ch.12-1.png": "bc7935fed8ae56ad1efdbdb24bf6e8db",
"assets/assets/characters/ch.10.png": "86fccf459a4f7374a787cecb3b935725",
"assets/assets/characters/ch.9.png": "af858a79e3ce2d5bf64ede06fe1d77d1",
"assets/assets/characters/ch.8-1.png": "b9b19680c22ad1ed01bfaf6c250b6573",
"assets/assets/characters/ch.6-1.png": "dd664ccc544bdd14e04a76003555c8c2",
"assets/assets/characters/ch.9-1.png": "fd9b0497537b89f3c22d40abcb511452",
"assets/assets/characters/default.png": "e3f2fbd6c5ee066b097b04a811d76e43",
"assets/assets/characters/ch.4-1.png": "1b3abb92fb1989e1689a8b4e07785f65",
"assets/assets/characters/ch.1.png": "dae703617abb0ac56a8347bed13d2a4c",
"assets/assets/characters/ch.8.png": "1f209dc8b1e4003981f451cd8e4203ab",
"assets/assets/characters/ch.7.png": "e62aa51f562ba5eb1cafa597e46f4883",
"assets/assets/characters/ch.1-1.png": "fa94079ad5dce7fae26a9403116c6c3f",
"assets/assets/characters/ch.7-1.png": "1a5d1d133de4f397aa4c820b1f0b5b3b",
"assets/assets/characters/ch.5-1.png": "3ef9e5efd7d67d15b4b13d2815fe4c42",
"assets/assets/characters/ch.3.png": "44e553bd9a0bd1ff0d325512bad2acbe",
"assets/assets/characters/ch.11.png": "29400fd693f05f00397804e0c169ad65",
"assets/assets/characters/ch.3-1.png": "d93e81b5f948afb871e842f7190b82b0",
"assets/assets/square_logo_768.png": "544d624c146482d76959b742f6901e6a",
"assets/assets/home_selected.svg": "2193b8db07b17c370127e662f71bace4",
"assets/assets/%25EB%258F%2599%25EB%25B0%25B1%25EA%25BD%2583.txt": "16fffd34ab99bdc3fad143c578dbbff8",
"assets/assets/user_selected.svg": "48da3cf16b02f72ce62348f5d666e101",
"assets/assets/%25EB%25A9%2594%25EB%25B0%2580%25EA%25BD%2583%25ED%2595%2584%25EB%25AC%25B4%25EB%25A0%25B5.txt": "4dbde7247c85912f9c05babd8d0649f5",
"assets/assets/logo.png": "001d4d643db59adfccfd87a50e32e239",
"assets/assets/kakao_signin.png": "b2df8abced56e0bbd49f7878a411e9c0",
"assets/assets/%25EB%2582%25A0%25EA%25B0%259C.txt": "dac5532886118288026dde4935433450",
"assets/assets/logo_terms.png": "7ab99a020344dc6b588d92bf68f8ac25",
"assets/assets/logo_login.png": "ccdaac743d00969908353e46e051a8be",
"assets/assets/%25EC%2597%2584%25EC%25A7%2580%25EA%25B3%25B5%25EC%25A3%25BC.txt": "cf299e4ee4b698b0957856edc976bc56",
"assets/assets/%25EC%258B%25AC%25EB%25B4%2589%25EC%2582%25AC.txt": "83c6623f493faf19ca55a2e367e5cfde",
"assets/assets/kakao_signup.png": "5908259919fe52dd000ed7acd4963cb9",
"assets/assets/fonts/BMJUA_ttf.ttf": "7dbe95a75200471524c4e5bc7a279708",
"assets/assets/fonts/NanumGothic.ttf": "77c9de73515a7120ac94e052eaa9218e",
"assets/assets/square_logo_1152.png": "0df5781b90d05905b41bf83f3c36b949",
"assets/assets/app_icon_white_bg.png": "1d962bf357deca6ff4218ac2693d7bae",
"assets/assets/message_selected.svg": "5bb93f31661828601bc961af23e1ce67",
"assets/assets/books/fairy_5.png": "1838705564919b20f0d48130214dbfcc",
"assets/assets/books/short_4.png": "921a8910853635d9f08cfd33f83e3853",
"assets/assets/books/fairy_6.png": "3985f8af5f06608836e3aa3d150c1e32",
"assets/assets/books/default_character.png": "e3f2fbd6c5ee066b097b04a811d76e43",
"assets/assets/books/long_1.png": "62bfe6382f0893555893c57218ed799a",
"assets/assets/books/fairy_1.png": "269c3fa558e1ff57b0a34e08a909483b",
"assets/assets/books/long_2.png": "7c7a0e6e61823aaa8cf514dd9bf2f936",
"assets/assets/books/broken_image.png": "a19a8db6354ee867e831db876608f24e",
"assets/assets/books/short_2.png": "70c6f5f138b25c95ead5c05ae6c19420",
"assets/assets/books/fairy_4.png": "1c8f93d55f5460f1dd8858e5eb6fe78b",
"assets/assets/books/fairy_2.png": "085bd6b0394e755da9d45d9331a91b4d",
"assets/assets/books/short_3.png": "d24770fb2fec3259b07561cf70878842",
"assets/assets/square_logo.png": "8211c0ac917a97a2e15f1db1a3aaecce",
"assets/assets/user.svg": "a50b28144fa9a2e032a97c4337db51ff",
"assets/assets/%25EC%259D%25B8%25EC%2596%25B4%25EA%25B3%25B5%25EC%25A3%25BC.txt": "2379cc264d398aac60d150bd4773369a",
"assets/assets/message.svg": "1005e290fc125901832e57bf86ca5b0e",
"assets/assets/terms_text.svg": "3541a7382de58d1ebd5ef440077a59c5",
"assets/assets/chat.svg": "1005e290fc125901832e57bf86ca5b0e",
"assets/assets/%25EB%25AF%25B8%25EC%259A%25B4%25EC%2595%2584%25EA%25B8%25B0%25EC%2598%25A4%25EB%25A6%25AC.txt": "39cf825507b0ca09702a1e3fba7952bf",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "02b612bf1930561cd75e97da0d43c841",
"assets/fonts/MaterialIcons-Regular.otf": "c45507010aafaefb3a7c7aa994278aaf",
"assets/FontManifest.json": "b958a7676eee4a57a64d810f4b7e9930",
"assets/AssetManifest.bin.json": "13012287a980c44694b47e11fa0f5376",
"assets/AssetManifest.json": "975bef58d97cda888118a3658350b619",
"version.json": "9ae83063e03dc458327489f17e7e2085",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"main.dart.js": "6258df01a6c58d935e668ede858b7349",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "d1a7fb888edaad90b17db5aaeaa9be4f",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "7437e96d48d716407aa8fc69640935e0"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
