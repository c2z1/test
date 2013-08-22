package de.xtask.domain

import com.googlecode.objectify.Ref
import com.googlecode.objectify.annotation.Cache
import com.googlecode.objectify.annotation.Entity
import java.util.Date
import java.text.DateFormat

@Entity
@Cache
class Task extends DatastoreObject {
	new() {
		state = TaskState.NEW
//		val user = LoginService.loggedInUser
//		println(user.email)
//		assignedTo = Ref.create(user)
		dateCreated = DateFormat.getDateInstance().format(new Date())
	}
	
	@Property
	private String name

	@Property
	private String description
	
	@Property
	private Ref<AppUser> assignedTo;
	
	@Property
	private TaskState state
	
	@Property
	private String dateCreated 
}