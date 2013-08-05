package de.xtask.server.service

import com.google.appengine.api.datastore.PreparedQuery.TooManyResultsException
import com.google.appengine.api.users.UserServiceFactory
import com.google.web.bindery.requestfactory.server.RequestFactoryServlet
import de.xtask.domain.AppUser
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class LoginService {
	public static final String AUTH_USER = "loggedInUser"

        def static AppUser login(HttpServletRequest req, HttpServletResponse res) {
                val userService = UserServiceFactory.getUserService()

                val userEmail = userService.getCurrentUser().getEmail()
                var loggedInUser = findUser(userEmail)
                if (loggedInUser == null) {
                        loggedInUser = addUser(userEmail)
                }
                req.setAttribute(AUTH_USER, loggedInUser)
                return loggedInUser
        }

        def static AppUser getLoggedInUser() {
                return RequestFactoryServlet::getThreadLocalRequest()
                                .getAttribute(AUTH_USER) as AppUser
        }

        def private static AppUser findUser(String userEmail) {
                try {
                	val au = new AppUserService()
                	au.getByEmail(userEmail)
                } catch (TooManyResultsException e) {
                        throw new RuntimeException(e)
                }
        }

        def private static AppUser addUser(String email) {
                val newUser = new AppUser(email)

                return newUser
        }

	
}