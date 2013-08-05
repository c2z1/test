package de.xtask.server.service

import com.google.web.bindery.requestfactory.shared.Request
import de.xtask.shared.TaskProxy
import java.util.List
import com.google.web.bindery.requestfactory.shared.InstanceRequest

class TaskService extends ObjectifyService {
	def Request<TaskProxy> findTask(String id) {
		
	}
  
  	def Request<List<TaskProxy>> findAllTasks() {
  		
  	}
  	
	def InstanceRequest<TaskProxy,Void> persist() {
		
	}
  
  	def InstanceRequest<TaskProxy,Void> remove() {
  		
  	}
}