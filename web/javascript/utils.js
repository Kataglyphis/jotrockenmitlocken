const setMessage = (function() {
	const texts = {
		de: {},
		en: {},
	};

	return function setMessage(language, elementId, messageDe, messageEn) {
		const element = document.getElementById(elementId);
		if (!element) return;

		const lang = language.substring(0, 2);
		const message = lang === 'de' ? messageDe : messageEn;
		element.textContent = message;
	};
})();
