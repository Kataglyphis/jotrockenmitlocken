{{flutter_js}}
{{flutter_build_config}}

window.addEventListener('load', function (ev) {
	// Download main.dart.js
	_flutter.loader.load({
		onEntrypointLoaded: async function(engineInitializer) {
			const appRunner = await engineInitializer.initializeEngine();
			await appRunner.runApp();
		}
		});
});