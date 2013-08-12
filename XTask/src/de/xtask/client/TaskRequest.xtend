package de.xtask.client

import com.google.web.bindery.requestfactory.shared.Request
import com.google.web.bindery.requestfactory.shared.RequestContext
import com.google.web.bindery.requestfactory.shared.Service
import de.xtask.server.TaskDao
import de.xtask.server.locator.DaoLocator
import java.util.List

@Service(value = typeof(TaskDao), locator = typeof(DaoLocator))
interface TaskRequest extends RequestContext {
	def Request<TaskProxy> findById(Long id)
	def Request<List<TaskProxy>> findOpenTasks()
	def Request<Void> persist(TaskProxy task)
	def Request<Void> removeAll(List<TaskProxy> tasks)
}