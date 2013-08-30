package de.xtask.client.event

import de.gwtannotations.GwtEvent
import de.xtask.client.TaskListProxy

@GwtEvent
class AddTaskEvent {
	TaskListProxy taskList
}