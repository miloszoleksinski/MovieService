package com.olas.filmsinfoservice.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;
import com.olas.filmsinfoservice.user.UserRepository;

@Component("myLogoutSuccessHandler")
public class MyLogoutSuccessHandler implements LogoutSuccessHandler
{
	@Autowired
	private UserRepository userRepository;
	
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException 
	{
		String username = authentication.getName();
		HttpSession session = request.getSession();
        if (session != null)
        {
            session.removeAttribute("user");
        }
        System.out.println("logout test");
		userRepository.updateLastSeen(username);
		response.sendRedirect("http://localhost:8080/SpringMvcExample/login?logout");
	}
}
