package de.xtask.client.presenter

import com.google.gwt.event.dom.client.HasClickHandlers
import com.google.gwt.user.client.ui.HasValue
import com.google.gwt.user.client.ui.HasWidgets
import com.google.gwt.user.client.ui.Widget
import com.google.web.bindery.event.shared.EventBus
import de.xtask.client.TaskProxy
import de.xtask.client.TaskRequest
import de.xtask.client.event.EditTaskCancelledEvent
import de.xtask.client.event.TaskUpdatedEvent

class EditTaskPresenter implements Presenter {

	var TaskProxy task
	val TaskRequest taskRequest
	val EventBus eventBus
	val EditTaskDisplay display

	public new(TaskRequest taskRequest, EventBus eventBus, EditTaskDisplay display) {
		this.taskRequest = taskRequest;
		this.eventBus = eventBus;
		this.task = taskRequest.create(typeof(TaskProxy));
		this.display = display;
		bind();
	}

	public new(TaskRequest taskRequest, EventBus eventBus, EditTaskDisplay display, TaskProxy task) {
		this.taskRequest = taskRequest;
		this.eventBus = eventBus;
		this.display = display;
		this.task = task
		display.name.setValue(task.name)
		display.description.setValue(task.description)
		bind();
	}
	
	def void bind() {
		display.getSaveButton().addClickHandler[doSave]
		display.getCancelButton().addClickHandler[eventBus.fireEvent(new EditTaskCancelledEvent())]
	}

	override void go(HasWidgets container) {
		container.clear();
		container.add(display.asWidget());
	}

	def private void doSave() {
		task.name = display.getName().getValue()
		task.description = display.getDescription().getValue()
		taskRequest.persist(task)
		eventBus.fireEvent(new TaskUpdatedEvent)
	}
}

public interface EditTaskDisplay {
	def HasClickHandlers getSaveButton()
	def HasClickHandlers getCancelButton();
	def HasValue<String> getName();
	def HasValue<String> getDescription();
	def Widget asWidget();
}
