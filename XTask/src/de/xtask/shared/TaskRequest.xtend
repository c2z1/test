package de.xtask.shared

import com.google.web.bindery.requestfactory.shared.RequestContext
import com.google.web.bindery.requestfactory.shared.Request
import java.util.List
import com.google.web.bindery.requestfactory.shared.Service
import de.xtask.domain.Task
import com.google.web.bindery.requestfactory.shared.InstanceRequest
import de.xtask.server.locator.TaskServiceLocator

@Service(value = typeof(Task), locator = typeof(TaskServiceLocator))
interface TaskRequest extends RequestContext {
	def Request<TaskProxy> findTask(String id)
	def Request<List<TaskProxy>> findAllTasks()
	def InstanceRequest<TaskProxy, Void> persist();
	def InstanceRequest<TaskProxy, Void> remove();
	
}