package de.xtask.client.presenter

import com.google.gwt.event.dom.client.ClickEvent
import com.google.gwt.event.dom.client.HasClickHandlers
import com.google.gwt.user.client.ui.HasWidgets
import com.google.gwt.user.client.ui.Widget
import com.google.web.bindery.event.shared.EventBus
import de.xtask.client.TaskProxy
import de.xtask.client.TaskRequestFactory
import de.xtask.client.event.AddTaskEvent
import de.xtask.client.event.EditTaskEvent
import java.util.List
import java.util.ArrayList

class TasksPresenter implements Presenter {

	private List<TaskProxy> tasks

	private final TaskRequestFactory taskRequestFactory
	private final EventBus eventBus
	private final TasksDisplay display

	public new(TaskRequestFactory taskRequestFactory, EventBus eventBus, TasksDisplay view) {
		this.taskRequestFactory = taskRequestFactory
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
		val selTasks = new ArrayList<TaskProxy>(display.getSelectedRows().map[tasks.get(it)])
		taskRequestFactory.taskRequest.removeAll(selTasks).fire[
			tasks.removeAll(selTasks)
			refreshView
		]
	}

	override go(HasWidgets container) {
		bind
		container.clear
		container.add(display.asWidget())
		taskRequestFactory.taskListRequest.createOrGetTaskList().with("tasks").fire[
				tasks = getTasks ?: newArrayList()
				refreshView
			]
//		taskRequestFactory.taskRequest.findOpenTasks().fire[List<TaskProxy> resultList |
//				tasks = new ArrayList<TaskProxy>(resultList)
//				refreshView
//			]
	}
	
	def refreshView() {
		display.setData(tasks.map[name])
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
