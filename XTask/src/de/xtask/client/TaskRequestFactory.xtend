package de.xtask.client

import com.google.web.bindery.requestfactory.shared.RequestFactory
import com.google.web.bindery.requestfactory.shared.Service
import de.xtask.client.TaskRequest
import de.xtask.server.TaskDao

@Service(value = typeof(TaskDao))
interface TaskRequestFactory extends RequestFactory {
	
	def TaskRequest taskRequest()
	def TaskListRequest taskListRequest()
	
}