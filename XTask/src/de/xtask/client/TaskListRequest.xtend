package de.xtask.client

import com.google.web.bindery.requestfactory.shared.Service
import de.xtask.server.locator.DaoLocator
import de.xtask.server.TaskListDao
import com.google.web.bindery.requestfactory.shared.Request
import java.util.List
import com.google.web.bindery.requestfactory.shared.RequestContext

@Service(value = typeof(TaskListDao), locator = typeof(DaoLocator))
interface TaskListRequest extends RequestContext {
	def Request<TaskListProxy> findById(Long id)
	def Request<List<TaskListProxy>> findAllTasklists()
	def Request<Void> persist(TaskListProxy tasklist)
	def Request<Void> removeAll(List<TaskListProxy> tasklists)
	
	def Request<TaskListProxy> createOrGetTaskList()
		
}