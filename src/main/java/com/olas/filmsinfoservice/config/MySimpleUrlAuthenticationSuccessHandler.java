package com.olas.filmsinfoservice.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.olas.filmsinfoservice.user.ActiveUserStore;
import com.olas.filmsinfoservice.user.LoggedUser;
import com.olas.filmsinfoservice.user.UserRepository;

@Component("myAuthenticationSuccessHandler")
public class MySimpleUrlAuthenticationSuccessHandler implements AuthenticationSuccessHandler
{
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private ActiveUserStore activeUserStore;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException 
	{
		String username = authentication.getName();
		HttpSession session = request.getSession(false);
		if (session != null) 
		{
            LoggedUser user = new LoggedUser(username, activeUserStore);
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(86400);
        }
		userRepository.updateLastSeen(username);
		response.sendRedirect("http://localhost:8080/SpringMvcExample/");
	}
}
