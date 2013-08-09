package de.xtask.server

import de.xtask.server.domain.AppUser

class AppUserService extends com.googlecode.objectify.ObjectifyService {
	new() {}
	
	def getByEmail(String string) {
		val ret = ofy.load.type(typeof(AppUser)).filter("email", string)
		if (ret.empty) null else ret.first.now
	}
}