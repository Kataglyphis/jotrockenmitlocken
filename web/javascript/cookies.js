(function() {
	// Consent lifetime. `Max-Age` (RFC 6265 §5.2.2) is used instead of
	// `Expires` because it takes a plain number of seconds, which is what the
	// previous `expires=2147483647` was mistakenly written as: `Expires` needs
	// an RFC 7231 HTTP-date ("Wed, 09 Jun 2038 00:00:00 GMT"), and a value the
	// browser cannot parse as one makes it IGNORE the attribute entirely. The
	// cookie was therefore a session cookie - the consent notice reappeared on
	// every new browser session, which is exactly the bug this replaces.
	//
	// 400 days is the cap Chrome (and, since 2022, the cookie RFC draft)
	// silently clamps any longer lifetime to, so asking for more only hides
	// what is actually stored.
	//
	// `path=/` is explicit for the same class of reason: with no path attribute
	// the cookie defaults to the directory of the requesting document, so a
	// consent given on a deep route would not be visible at the site root.
	// A site-wide consent cookie has to say so.
	const CONSENT_MAX_AGE_SECONDS = 400 * 24 * 60 * 60;

	function setCookie(name, value) {
		const attributes = '; Max-Age=' + CONSENT_MAX_AGE_SECONDS + '; path=/; SameSite=Strict; Secure';
		document.cookie = name + '=' + (value || '') + attributes;
	}

	function getCookie(name) {
		const nameEQ = name + '=';
		const ca = document.cookie.split(';');
		for (let i = 0; i < ca.length; i++) {
			let c = ca[i];
			while (c.charAt(0) === ' ') c = c.substring(1, c.length);
			if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
		}
		return null;
	}

	function initCookieNotice() {
		const notice = document.getElementById('cookie-notice');
		const consentBtn = document.getElementById('cookie-consent');
		const cookieKey = 'cookie-consent';
		const cookieValue = 'true';

		if (getCookie(cookieKey) === cookieValue) return;

		notice.classList.add('show');
		consentBtn.addEventListener('click', function(e) {
			e.preventDefault();
			setCookie(cookieKey, cookieValue);
			notice.classList.remove('show');
		});
	}

	initCookieNotice();
})();
