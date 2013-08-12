package de.xtask.server.domain

import javax.persistence.Entity
import com.googlecode.objectify.Key

@Entity
class Task extends DatastoreObject {
	new() {
		state = TaskState.NEW
	}
	
	@Property
	private String name

	@Property
	private String description
	
	@Property
	private Key<AppUser> owner;
	
	@Property
	private TaskState state
}