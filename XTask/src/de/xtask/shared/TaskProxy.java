package de.xtask.shared;

import com.google.web.bindery.requestfactory.shared.EntityProxy;
import com.google.web.bindery.requestfactory.shared.ProxyFor;
import de.xtask.domain.Task;
import de.xtask.server.locator.ObjectifyLocator;

@ProxyFor(value = Task.class, locator = ObjectifyLocator.class)
@SuppressWarnings("all")
public interface TaskProxy extends EntityProxy {
  public abstract String getDescription();
  
  public abstract void setDescription(final String str);
  
  public abstract String getName();
  
  public abstract void setName(final String str);
}
