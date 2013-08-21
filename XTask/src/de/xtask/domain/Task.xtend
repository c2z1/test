package de.xtask.domain

import com.googlecode.objectify.Key
import com.googlecode.objectify.annotation.Cache
import com.googlecode.objectify.annotation.Entity

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
	private Key<AppUser> assignedTo;
	
	@Property
	private TaskState state
}