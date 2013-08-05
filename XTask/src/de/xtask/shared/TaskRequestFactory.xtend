package de.xtask.shared

import com.google.web.bindery.requestfactory.shared.RequestFactory

interface TaskRequestFactory extends RequestFactory {
	
	def TaskRequest taskRequest()
	
}