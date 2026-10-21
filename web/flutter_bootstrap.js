{{flutter_js}}
{{flutter_build_config}}

// Fallback fonts (emoji, symbols) from this site: the engine's default is fonts.gstatic.com, which the CSP blocks.
_flutter.loader.load({
  serviceWorkerSettings: {
    serviceWorkerVersion: {{flutter_service_worker_version}},
  },
  config: {
    fontFallbackBaseUrl: "fallback-fonts/",
  },
});
