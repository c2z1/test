package de.xtask.client

import com.google.gwt.event.logical.shared.ValueChangeEvent
import com.google.gwt.user.client.History
import com.google.gwt.user.client.Window.Location
import com.google.gwt.user.client.ui.HasWidgets
import com.google.web.bindery.event.shared.EventBus
import de.xtask.client.auth.AuthFailureEvent
import de.xtask.client.event.AddTaskEvent
import de.xtask.client.event.EditTaskCancelledEvent
import de.xtask.client.event.EditTaskEvent
import de.xtask.client.event.TaskUpdatedEvent
import de.xtask.client.presenter.EditTaskPresenter
import de.xtask.client.presenter.TasksPresenter
import de.xtask.client.view.EditTaskView
import de.xtask.client.view.TasksView

class AppController {
	TaskRequestFactory taskRequestFactory
	EventBus eventBus
	HasWidgets container

	new(TaskRequestFactory taskRequestFactory, EventBus eventBus) {
		this.taskRequestFactory = taskRequestFactory
		this.eventBus = eventBus
		bind()
	}

	def void bind() {
		History.addValueChangeHandler[handleValueChanged]

	    eventBus.addHandler(AddTaskEvent.TYPE, [
	    	History.newItem("add")
	    	new EditTaskPresenter(taskRequestFactory, eventBus, new EditTaskView()).go(container);
	    ])
	    eventBus.addHandler(EditTaskEvent.TYPE, [
	    	History.newItem("edit", false)
    		new EditTaskPresenter(taskRequestFactory.taskRequest, eventBus, new EditTaskView(), task).go(container);
	    ])
	    eventBus.addHandler(TaskUpdatedEvent.TYPE, [History.newItem("list")])
	    eventBus.addHandler(EditTaskCancelledEvent.TYPE, [History.newItem("list")])
	    eventBus.addHandler(AuthFailureEvent.TYPE, [Location.replace(loginUrl)])
	}

	def private handleValueChanged(ValueChangeEvent<String> event) {
		val token = event.getValue();

		if (token != null) {
			switch (token) {
				case "list" :
					new TasksPresenter(taskRequestFactory, eventBus, new TasksView())
		      	default :
		        	new EditTaskPresenter(taskRequestFactory.taskRequest, eventBus, new EditTaskView())
			}.go(container);
		}
	}

	def go(HasWidgets container) {
		this.container = container;

		if ("" == History.getToken()) {
			History.newItem("list");
		} else {
			History.fireCurrentHistoryState();
		}
	}
}