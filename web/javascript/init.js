(function() {
	const userLanguage = (navigator.language || navigator.userLanguage || 'en').substring(0, 2);

	const messageEnCookie = "I only use technically necessary cookies to provide services.\n" +
		"Further information can be found in the cookie statement at the bottom of the website.\nHave fun :)";
	const messageDeCookie = "Ich verwende ausschließlich technisch notwendige Cookies, um Dienstleistungen zu erbringen.\n" +
		"Weitere Informationen finden Sie in der Cookie Erklärung im unteren Teil der Website. Viel Spaß :)";
	setMessage(userLanguage, 'message', messageDeCookie, messageEnCookie);

	const messageEnLoading = 'You will be there soon ...';
	const messageDeLoading = 'Noch etwas Geduld ...';
	setMessage(userLanguage, 'loading-message', messageDeLoading, messageEnLoading);
})();
