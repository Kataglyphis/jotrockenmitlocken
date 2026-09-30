(function() {
	// Max-Age, since an unparsable Expires is ignored (session cookie); 400 days is the browser cap; path=/ spans the site.
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
