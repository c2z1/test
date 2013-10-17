package de.xtask.client

import com.google.web.bindery.requestfactory.shared.ProxyFor
import de.xtask.domain.TaskList
import de.xtask.server.locator.ObjectifyLocator
import java.util.List
import com.google.web.bindery.requestfactory.shared.EntityProxy

@ProxyFor(value = typeof(TaskList), locator = typeof(ObjectifyLocator))
interface TaskListProxy extends EntityProxy {
	def String getName()
	def void setName(String name)
	
	def List<TaskProxy> getTasks()
	def void setTasks(List<TaskProxy> tasks)
}