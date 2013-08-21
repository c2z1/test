package de.xtask.domain

import com.googlecode.objectify.annotation.Entity

@Entity
class AppUser extends DatastoreObject {
	new() {	}
	new(String email) {	}
	@Property
	private String email
}