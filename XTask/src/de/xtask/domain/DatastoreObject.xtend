package de.xtask.domain

import com.googlecode.objectify.annotation.Id
import com.googlecode.objectify.annotation.OnSave

abstract class DatastoreObject {
 
    @Id
    @Property
    private Long id;
 
 	@Property
    private Integer version = 0;

    /**
     * Auto-increment version # whenever persisted
     */
    @OnSave
    def void onSave() {
        version = version + 1
    }
}