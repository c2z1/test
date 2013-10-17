package de.xtask.client.auth

import de.gwtannotations.GwtEvent

@GwtEvent
class AuthFailureEvent {
	String loginUrl
}