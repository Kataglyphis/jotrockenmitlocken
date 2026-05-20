(function() {
	function setCookie(name, value) {
		const expires = '; expires=2147483647; SameSite=Strict; Secure';
		document.cookie = name + '=' + (value || '') + expires;
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
