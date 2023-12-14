'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"manifest.json": "93b435a70934830ff4967caad2378fd0",
"favicon.png": "f8cbeff205d7d8de3b824b42beec7fd2",
"index.html": "3931f58a9fb8a657aa2d5459e16b6785",
"/": "3931f58a9fb8a657aa2d5459e16b6785",
"main.dart.js": "ba6866fe5069a1902f05800b5ebe5107",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.json": "a52649baa736147aeb49e60b68f8756a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/AssetManifest.bin": "280c17a789dd5b7a099ab93bc95310fc",
"assets/assets/images/tmdb/alt-short.svg": "56fd61eec148690af48f876dfd5c8718",
"assets/assets/images/tmdb/primary-long.svg": "31d26327470d3d7f96f7bed3417fe659",
"assets/assets/images/tmdb/primary-short.svg": "08392f186e99a74794065effff6f90e5",
"assets/assets/images/tmdb/alt-long.svg": "86ff7c17f7e92af5da77274697bbff25",
"assets/assets/images/tmdb/primary-full.svg": "24a6fdb93a3bb0275107bfc71637cb21",
"assets/assets/images/app-icon.png": "49b9590128fb4775b227b4ccd6681053",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/fonts/MaterialIcons-Regular.otf": "c82e9e546be01e701ae46e9024c021fc",
"assets/NOTICES": "233e2ca7fdbf1274ed23c87ff97e0931",
"assets/policies/terms-of-use.md": "6651ec66f8d071f7e6277fc1136acc05",
"assets/policies/privacy-policy.md": "690a495c7f2471a0bd8ee4061493c4eb",
"version.json": "11c3e7517cb27ac07bcc32f68b8b78bc",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"icons/Icon-512.png": "99167859e575099ed7a0fc56762d4ff7",
"icons/Icon-maskable-512.png": "99167859e575099ed7a0fc56762d4ff7",
"icons/Icon-192.png": "72fc2a029a9c1dcc94e837a354219ecf",
"icons/Icon-maskable-192.png": "72fc2a029a9c1dcc94e837a354219ecf",
"404.html": "04ac55bfc0877fadbf72d58ec8484aae",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"splash/img/light-3x.png": "245273b7f6f14fff60dc7006573388c1",
"splash/img/dark-2x.png": "5da5db7a4224ab1b867b92485e886d3b",
"splash/img/light-1x.png": "6b61145fdbae1c38741cfcaf51f517ba",
"splash/img/dark-3x.png": "245273b7f6f14fff60dc7006573388c1",
"splash/img/dark-4x.png": "99167859e575099ed7a0fc56762d4ff7",
"splash/img/light-2x.png": "5da5db7a4224ab1b867b92485e886d3b",
"splash/img/dark-1x.png": "6b61145fdbae1c38741cfcaf51f517ba",
"splash/img/light-4x.png": "99167859e575099ed7a0fc56762d4ff7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
