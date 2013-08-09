package de.xtask.server.domain

import javax.persistence.Entity

@Entity
class AppUser extends DatastoreObject {
	new() {	}
	new(String email) {	}
	@Property
	private String email
}