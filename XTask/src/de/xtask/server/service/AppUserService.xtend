package de.xtask.server.service

import de.xtask.domain.AppUser

class AppUserService extends com.googlecode.objectify.ObjectifyService {
	new() {}
	
	def getByEmail(String string) {
		val ret = ofy.load.type(typeof(AppUser)).filter("email", string)
		if (ret.empty) null else ret.first.now
	}
}