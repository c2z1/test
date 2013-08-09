package de.xtask.client.presenter

import com.google.gwt.event.dom.client.ClickEvent
import com.google.gwt.event.dom.client.HasClickHandlers
import com.google.gwt.user.client.ui.HasWidgets
import com.google.gwt.user.client.ui.Widget
import com.google.web.bindery.event.shared.EventBus
import de.xtask.client.TaskProxy
import de.xtask.client.TaskRequest
import de.xtask.client.event.AddTaskEvent
import de.xtask.client.event.EditTaskEvent
import java.util.List

class TasksPresenter implements Presenter {

	private List<TaskProxy> tasks

	private final TaskRequest taskRequest
	private final EventBus eventBus
	private final TasksDisplay display

	public new(TaskRequest taskRequest, EventBus eventBus, TasksDisplay view) {
		this.taskRequest = taskRequest
		this.eventBus = eventBus
		this.display = view
	}

	def void bind() {
		display.getAddButton().addClickHandler[eventBus.fireEvent(new AddTaskEvent())]
		display.getDeleteButton().addClickHandler[deleteSelectedTasks]
		display.getList().addClickHandler[clickEvent|
			val selectedRow = display.getClickedRow(clickEvent)
			if (selectedRow >= 0) {
				eventBus.fireEvent(new EditTaskEvent(tasks.get(selectedRow)))
			}
		]
	}
	
	def deleteSelectedTasks() {
		display.getSelectedRows().forEach[taskRequest.remove().using(tasks.get(it))]
	}

	override go(HasWidgets container) {
		bind();
		container.clear();
		container.add(display.asWidget());
		taskRequest.findAllTasks().fire[List<TaskProxy> resultList |
					tasks = resultList
					display.setData(tasks.map[name])]
	}
}

public interface TasksDisplay {
	def HasClickHandlers getAddButton()
	def HasClickHandlers getDeleteButton()
	def HasClickHandlers getList()
	def void setData(List<String> data)
	def int getClickedRow(ClickEvent event)
	def List<Integer> getSelectedRows()
	def Widget asWidget()
}
