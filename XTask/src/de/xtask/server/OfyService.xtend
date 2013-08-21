package de.xtask.server

import com.googlecode.objectify.ObjectifyService
import de.xtask.domain.AppUser
import de.xtask.domain.Task

public class OfyService {
	
	static boolean registered = false
	
    private def static register() {
        factory.register(typeof(AppUser))
        factory.register(typeof(Task))
        registered = true
    }

    def static ofy() {
    	if (!registered) register
        ObjectifyService.ofy
    }

    private def static factory() {
        ObjectifyService.factory
    }
}
