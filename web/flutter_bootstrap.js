{{flutter_js}}
{{flutter_build_config}}

// Fallback fonts (emoji, symbols) from this site: the engine's default is fonts.gstatic.com, which the CSP blocks.
_flutter.loader.load({
  serviceWorkerSettings: {
    serviceWorkerVersion: {{flutter_service_worker_version}},
  },
  config: {
    fontFallbackBaseUrl: "fallback-fonts/",
    // Multi-threaded skwasm throws a worker TypeError on load (hub CON150); Flutter 3.50.1 fixes its worker locks.
    forceSingleThreadedSkwasm: true,
  },
});
