package de.xtask.server.locator

import com.google.web.bindery.requestfactory.shared.Locator
import de.xtask.domain.DatastoreObject
import static de.xtask.server.service.OfyService.*

class ObjectifyLocator extends Locator<DatastoreObject, Long> {
    override create(Class<? extends DatastoreObject> clazz) {
        try {
			return clazz.newInstance();
		} catch (InstantiationException e) {
			throw new RuntimeException(e);
		} catch (IllegalAccessException e) {
			throw new RuntimeException(e);
		}
    }
 
    override find(Class<? extends DatastoreObject> clazz, Long id) {
		return ofy.load.type(clazz).id(id).now
	}
 
    override getDomainType() {
		// Never called
		return null;
	}
 
    override getId(DatastoreObject domainObject) {
        return domainObject.getId();
    }
 
    override getIdType() {
		return typeof(Long);
	}
 
    override getVersion(DatastoreObject domainObject) {
		return domainObject.getVersion();
	}
}