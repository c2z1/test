package de.gwtannotations.test

import org.junit.Test
import org.eclipse.xtend.core.compiler.batch.XtendCompilerTester

class GwtEventTest {

	extension XtendCompilerTester compilerTester = XtendCompilerTester::newXtendCompilerTester(typeof(GwtEventTest))

	@Test def void testGwtEvent() {
		'''
			import de.gwtannotations.GwtEvent
			@GwtEvent
			class MyActionEvent {
			}
		'''.assertCompilesTo(
			'''
				MULTIPLE FILES WERE GENERATED

				File 1 : MyActionEvent.java

				import de.gwtannotations.GwtEvent;

				@GwtEvent
				@SuppressWarnings("all")
				public class MyActionEvent {
				  public static Type<MyActionEventHandler> TYPE = new Type<MyActionEventHandler>();

				  protected void dispatch(MyActionEventHandler handler) {
					handler.onAddTask(this);
				  }

				  public Type<MyActionEventHandler> getAssociatedType() {
					return TYPE;
				  }
				}
				
				File 2 : MyActionEventHandler.java
				
				@SuppressWarnings("all")
				public interface MyActionEventHandler {
				  public void onMyAction();
				}
				
			''')
	}
}
