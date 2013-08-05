package de.xtask.domain

import de.xtask.domain.DatastoreObject
import javax.persistence.Entity

@Entity
class AppUser extends DatastoreObject {
	new() {	}
	new(String email) {	}
	@Property
	private String email
}