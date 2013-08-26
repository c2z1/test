package de.xtask.server.servlet

import com.google.web.bindery.requestfactory.server.RequestFactoryServlet
import com.google.web.bindery.requestfactory.server.DefaultExceptionHandler
import java.util.logging.Logger
import com.google.web.bindery.requestfactory.shared.ServerFailure
import java.util.logging.Level

class XRequestFactoryServlet extends RequestFactoryServlet {
	new() {
		super(new XDefaultExceptionHandler());
	}
}

class XDefaultExceptionHandler extends DefaultExceptionHandler {
	private static final Logger logger = Logger.getLogger(typeof(XDefaultExceptionHandler).getCanonicalName());

	override ServerFailure createServerFailure(Throwable throwable) {
		logger.log(Level.SEVERE, "", throwable);
		return super.createServerFailure(throwable);
	}
}