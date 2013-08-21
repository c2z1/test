package de.xtask.server

import com.googlecode.objectify.ObjectifyService
import de.xtask.domain.AppUser
import de.xtask.domain.Task

public class OfyService {
	
	static boolean isInit = false
	
    private def static register() {
    	if (isInit) {
	        isInit = true
	        factory.register(typeof(AppUser))
	        factory.register(typeof(Task))
        }
    }

    def static ofy() {
    	register
        ObjectifyService.ofy
    }

    private def static factory() {
        ObjectifyService.factory
    }
}
