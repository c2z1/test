package de.xtask.shared.auth

interface GaeHelper {
  /**
   * The placeholder token added to the login URL. The client replaces the token
   * with the current href, which only the client knows.
   */
  /* Prefixed with http:// to ensure that GAE doesn't automatically prefix it. */
  static String REDIRECT_URL_TOKEN = "http%3A%2F%2FREDIRECTURL";
	
}