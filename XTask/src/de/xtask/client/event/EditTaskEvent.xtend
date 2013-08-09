package de.xtask.client.event

import de.gwtannotations.GwtEvent

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