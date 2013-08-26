package de.xtask.server

import de.xtask.domain.TaskList

import static de.xtask.server.OfyService.*
import java.util.List

class TaskListDao {
	def void persist(TaskList task) {
		ofy.save.entity(task).now
	}
 
	def void removeAll(List<TaskList> task) {
		ofy.delete.entities(task).now
	}
	
  	def TaskList findById(Long id) {
    	ofy.load.type(typeof(TaskList)).id(id).now
  	}
  	
  	def List<TaskList> findAllTasklists() {
    	ofy.load.type(typeof(TaskList)).list
  	}	
  	
  	def TaskList createOrGetTaskList() {
  		val l = findAllTasklists
  		if (l.empty) {
  			val t = new TaskList("Test")
  			persist(t)
  			t
  		} else {
  			l.head
  		}
  	}
  	
}