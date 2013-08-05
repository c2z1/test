package de.xtask.server.locator

import com.google.web.bindery.requestfactory.shared.ServiceLocator

class TaskServiceLocator implements ServiceLocator {
	override getInstance(Class<? extends Object> clazz) {
	    try {
	    	return clazz.newInstance();
	    } catch (InstantiationException e) {
	      	throw new RuntimeException(e);
	    } catch (IllegalAccessException e) {
	      	throw new RuntimeException(e);
	    }
	}
}