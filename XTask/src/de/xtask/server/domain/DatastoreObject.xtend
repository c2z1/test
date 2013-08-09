package de.xtask.server.domain

import javax.persistence.Id
import javax.persistence.PrePersist

class DatastoreObject {
 
    @Id
    @Property
    private Long id;
 
 	@Property
    private Integer version = 0;

    /**
     * Auto-increment version # whenever persisted
     */
    @PrePersist
    def void onPersist() {
        version = version + 1
    }
}