package de.xtask.client.event

import com.google.gwt.user.client.rpc.AsyncCallback
import com.google.gwt.user.client.Window

class XAsyncCallback<T> implements AsyncCallback<T> {
	val (T)=>void success
	val String errorMsg

	new((T)=>void success, String errorMsg) {
		this.success = success
		this.errorMsg = errorMsg
	}

	override onSuccess(T result) {
		success.apply(result)
	}

	override onFailure(Throwable caught) {
		Window::alert(errorMsg);
	}
}
