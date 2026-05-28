{{flutter_js}}
{{flutter_build_config}}

(async function () {
  var ua = navigator.userAgent || "";
  var isMetaInApp = /(FBAN|FBAV|FB_IAB|Instagram|Messenger)/i.test(ua);

  if (isMetaInApp && "serviceWorker" in navigator) {
    try {
      var registrations = await navigator.serviceWorker.getRegistrations();
      await Promise.all(
        registrations.map(function (registration) {
          return registration.unregister();
        })
      );
    } catch (_) {
      // Ignore cleanup failures and continue app startup.
    }
  }

  if (isMetaInApp && window._flutter && _flutter.buildConfig && Array.isArray(_flutter.buildConfig.builds)) {
    var nonCanvasKitBuilds = _flutter.buildConfig.builds.filter(function (build) {
      return build && build.renderer !== "canvaskit";
    });

    if (nonCanvasKitBuilds.length > 0) {
      _flutter.buildConfig.builds = nonCanvasKitBuilds;
    }
  }

  _flutter.loader.load();
})();
