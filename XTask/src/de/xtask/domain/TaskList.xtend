package de.xtask.domain

import com.googlecode.objectify.annotation.Entity
import com.googlecode.objectify.annotation.Cache
import com.googlecode.objectify.Ref
import java.util.List
import com.googlecode.objectify.annotation.Load
import java.util.Collections

@Entity
@Cache
class TaskList extends DatastoreObject {
	
	@Property
	String name
	
	@Load List<Ref<Task>> tasks
	
	new() {
	}
	new(String name) {
		this.name = name
	}
	
	def List<Task> getTasks() {
		if (tasks == null) Collections.emptyList else tasks.map[get]
	}
	def void setTasks(List<Task> taskList) {
		tasks = taskList.map[Ref.create(it)]
	}
}