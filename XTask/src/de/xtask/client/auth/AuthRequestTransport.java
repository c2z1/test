package de.xtask.client.auth;

import com.google.gwt.http.client.Request;
import com.google.gwt.http.client.RequestCallback;
import com.google.gwt.http.client.Response;
import com.google.gwt.user.client.Window;
import com.google.web.bindery.event.shared.EventBus;
import com.google.web.bindery.requestfactory.gwt.client.DefaultRequestTransport;
import com.google.web.bindery.requestfactory.shared.ServerFailure;

import de.xtask.shared.auth.GaeHelper;

/**
 * Extends DefaultRequestTransport to handle the authentication failures
 * reported by {@link com.google.gwt.sample.gaerequest.server.GaeAuthFilter}.
 */
public class AuthRequestTransport extends DefaultRequestTransport {
  private final EventBus eventBus;

  public AuthRequestTransport(EventBus eventBus) {
    this.eventBus = eventBus;
  }

  @Override
  protected RequestCallback createRequestCallback(final TransportReceiver receiver) {
    final RequestCallback superCallback = super.createRequestCallback(receiver);

    return new RequestCallback() {
      public void onError(Request request, Throwable exception) {
        superCallback.onError(request, exception);
      }

      public void onResponseReceived(Request request, Response response) {
        /*
         * The GaeAuthFailure filter responds with Response.SC_UNAUTHORIZED and
         * adds a "login" url header if the user is not logged in. When we
         * receive that combo, post an event so that the app can handle things
         * as it sees fit.
         */

        if (Response.SC_UNAUTHORIZED == response.getStatusCode()) {
          String loginUrl = response.getHeader("login");
          if (loginUrl != null) {
            // Replace the redirect url placeholder with the current url.
            loginUrl = loginUrl.replace(GaeHelper.REDIRECT_URL_TOKEN, Window.Location.getHref());

            /*
             * Hand the receiver a non-fatal callback, so that *
             * com.google.web.bindery.requestfactory.shared.Receiver will not
             * post a runtime exception.
             */
            receiver
                .onTransportFailure(new ServerFailure("Unauthenticated user", null, null, false));
            eventBus.fireEvent(new AuthFailureEvent(loginUrl));
            return;
          }
        }
        superCallback.onResponseReceived(request, response);
      }
    };
  }
}
