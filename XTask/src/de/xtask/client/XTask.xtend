package de.xtask.client

import com.google.gwt.core.client.EntryPoint
import com.google.gwt.core.client.GWT
import com.google.gwt.user.client.Window
import com.google.gwt.user.client.ui.RootPanel
import com.google.web.bindery.event.shared.SimpleEventBus
import de.xtask.client.auth.AuthRequestTransport

class XTask implements EntryPoint {

	override onModuleLoad() {
		GWT.setUncaughtExceptionHandler[
	        Window.alert("Uncaught Exception: " + getMessage());
	        printStackTrace();
		]

		val TaskRequestFactory taskRequestFactory = GWT::create(typeof(TaskRequestFactory))
	    val eventBus = new SimpleEventBus
	    taskRequestFactory.initialize(eventBus, new AuthRequestTransport(eventBus))
	    val appController = new AppController(taskRequestFactory, eventBus)
	    appController.go(RootPanel::get());
	}
}