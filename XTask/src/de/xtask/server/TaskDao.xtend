package de.xtask.server

import de.xtask.server.domain.Task
import java.util.List

import static de.xtask.server.OfyService.*

class TaskDao {
	def void persist(Task task) {
		ofy.save.entity(task).now
	}
 
	def void remove(Task task) {
		ofy.delete.entity(task).now
	}
 
  	def Task findById(Long id) {
    	return ofy.load.type(typeof(Task)).id(id).now
  	}
  	
  	def List<Task> findOpenTasks() {
    	return ofy.load.type(typeof(Task)).filter("name !=", "dsfjkdjfsdfddfdf").list
  	}
}