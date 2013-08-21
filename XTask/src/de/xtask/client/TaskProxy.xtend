package de.xtask.client

import com.google.web.bindery.requestfactory.shared.EntityProxy
import com.google.web.bindery.requestfactory.shared.ProxyFor
import de.xtask.domain.Task
import de.xtask.server.locator.ObjectifyLocator

@ProxyFor(value = typeof(Task), locator = typeof(ObjectifyLocator))
@SuppressWarnings("all")
public interface TaskProxy extends EntityProxy {
  def String getDescription();
  
  def void setDescription(String str);
  
  def String getName();
  
  def void setName(String str);
}