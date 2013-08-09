package de.xtask.client.event

import de.gwtannotations.GwtEventimport de.xtask.client.TaskProxy

@GwtEvent
class EditTaskEvent {
	TaskProxy task;
	new(TaskProxy task) {
		this.task = task
	}
	def getTask() {
		task
	}
}