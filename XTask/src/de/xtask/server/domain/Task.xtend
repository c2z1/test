package de.xtask.server.domain

import com.googlecode.objectify.Key
import com.googlecode.objectify.annotation.Entity
import com.googlecode.objectify.annotation.Cache

@Entity
@Cache
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