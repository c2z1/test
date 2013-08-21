package de.xtask.server.servlet

import com.google.appengine.api.users.UserServiceFactory
import de.xtask.server.LoginService
import java.io.IOException
import javax.servlet.Filter
import javax.servlet.FilterChain
import javax.servlet.FilterConfig
import javax.servlet.ServletException
import javax.servlet.ServletRequest
import javax.servlet.ServletResponse
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class AuthenticationFilter implements Filter {

        override destroy() {}

        override doFilter(ServletRequest servletRequest,
                        ServletResponse servletResponse, FilterChain filterChain)
                        throws IOException, ServletException {
            val userService = UserServiceFactory.getUserService();
            val request = servletRequest as HttpServletRequest;
            val response = servletResponse as HttpServletResponse;

            if (!userService.isUserLoggedIn()) {
                    response.setHeader("login", userService.createLoginURL(request.getRequestURI()))
                    response.sendError(HttpServletResponse.SC_UNAUTHORIZED)
            } else {
				LoginService.login(request, response)
                filterChain.doFilter(request, response)
			}
        }

        override init(FilterConfig config) {}
}
