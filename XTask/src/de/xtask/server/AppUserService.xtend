package de.xtask.server

import de.xtask.domain.AppUser
import static de.xtask.server.OfyService.*

class AppUserService {
	new() {}
	
	def getByEmail(String string) {
		val ret = ofy.load.type(typeof(AppUser)).filter("email", string)
		if (ret.empty) null else ret.first.now
	}
}