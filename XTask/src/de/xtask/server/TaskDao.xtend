package de.xtask.server

import de.xtask.server.domain.Task
import java.util.List

import static de.xtask.server.OfyService.*

class TaskDao {
	def void persist(Task task) {
		ofy.save.entity(task).now
	}
 
	def void removeAll(List<Task> task) {
		ofy.delete.entities(task).now
	}
	
  	def Task findById(Long id) {
    	ofy.load.type(typeof(Task)).id(id).now
  	}
  	
  	def List<Task> findOpenTasks() {
    	val l = ofy.load.type(typeof(Task)).list
    	l
  	}
}